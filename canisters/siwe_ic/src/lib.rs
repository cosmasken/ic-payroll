use candid::{Principal, CandidType};
use futures::executor::block_on;
use hex::FromHex;
use ic_cdk_macros::{query, update};
use siwe::{Message, VerificationOpts};
use std::collections::BTreeMap;
use std::str::FromStr;
use time::format_description::well_known::Rfc3339;
use time::OffsetDateTime;


const SESSION_EXPIRATION_IN_MINS: i64 = 5;
const CLEANUP_INTERCAL_IN_MINS: i64 = 15;

#[derive(Clone, Debug, CandidType)]
struct Session {
    address: String,
    expires_at: i64,   
}

type SessionMap = BTreeMap<Principal, Session>;

thread_local! {
    static SESSIONS: std::cell::RefCell<SessionMap> = std::cell::RefCell::new(BTreeMap::new());
    static LAST_CLEANUP: std::cell::RefCell<OffsetDateTime> = std::cell::RefCell::new(OffsetDateTime::from_unix_timestamp(0).unwrap());
}


async fn validate(msg: &Message, sig: &str) -> [u8; 20] {
    
    let opts = VerificationOpts {
        domain: None,
        nonce: None,
        timestamp: Some(OffsetDateTime::from_unix_timestamp((ic_cdk::api::time() / (1_000_000_000)) as i64).unwrap())
    };

    // Check if uri is equal to the caller
    msg.uri.to_string().eq(&format!("did:icp:{}",ic_cdk::api::caller().to_text())).then(|| ()).ok_or("Invoked by unauthorized principal").unwrap();
    
    // Check if target (canister and method) is part of authorized resources
    let target = format!("icp:{}",ic_cdk::api::id().to_text());
    msg.resources.clone().into_iter().find(|r| r.as_str().eq(&target)).ok_or(format!("Unauthorized for resource: {}", &target)).unwrap();

    let sig = <[u8; 65]>::from_hex( sig.strip_prefix("0x").unwrap_or(sig)).unwrap();

    block_on(msg.verify(&sig, &opts)).unwrap();

    msg.address
}

fn check_session() -> Result<String, String> {
    
    let caller = ic_cdk::api::caller();
    let now =  (ic_cdk::api::time() / (1_000_000_000)) as i64;

    ic_cdk::api::print(std::format!("Checking session for {}", ic_cdk::api::caller().to_text()));

    SESSIONS.with(|sessions| {
        let mut sessions = sessions.borrow_mut();
        let session = sessions.get(&caller).ok_or("No session found")?;
        if session.expires_at < now {
            sessions.remove(&caller);
            Err("Session expired".to_string())
        } else {
            Ok(session.address.clone())
        }

    })
}


#[query]
fn greet(name: String) -> String {
    let caller = check_session().unwrap();
    ic_cdk::api::print(std::format!("Active session for {}", caller));
    format!("Hello, {}!", name)
}


#[update]
async fn create_session(siwe_msg: String, siwe_sig: String) -> Result<Session, String> {

    ic_cdk::api::print(std::format!("Creating session for {}...", ic_cdk::api::caller().to_text()));

    let msg = Message::from_str(&siwe_msg).unwrap();
    block_on(validate(&msg, &siwe_sig));

    let address = hex::encode(msg.address);

    ic_cdk::api::print(std::format!("Associated ETH account {:?}", address));

    let now =  OffsetDateTime::from_unix_timestamp((ic_cdk::api::time() / 1_000_000_000) as i64).unwrap();
    
    let issued_at = OffsetDateTime::parse(&msg.issued_at.to_string(), &Rfc3339).unwrap();
    let expires_at = issued_at + time::Duration::minutes(SESSION_EXPIRATION_IN_MINS);

    
    
    let session = Session {
        address,
        expires_at: expires_at.unix_timestamp(),
    };

    SESSIONS.with(|sessions| {
        let mut sessions = sessions.borrow_mut();
        sessions.insert(ic_cdk::api::caller(), session.clone());
    });

    ic_cdk::api::print(std::format!("Created session for {}, expires at {:?}", ic_cdk::api::caller().to_text(), expires_at));

    LAST_CLEANUP.with(|last_cleanup| {
        let mut last_cleanup = last_cleanup.borrow_mut();
        if now - *last_cleanup > time::Duration::minutes(CLEANUP_INTERCAL_IN_MINS) {
            _cleanup_sessions();
            *last_cleanup = now;
        }
    });

    Ok(session)
}

#[query]
fn get_session() -> Result<Session, String> {
    check_session().unwrap();
    SESSIONS.with(|sessions| {
        let sessions = sessions.borrow();
        let session = sessions.get(&ic_cdk::api::caller()).ok_or("No session found. Please sign in.")?;
        Ok(session.clone())
    })
}

#[update]
fn clear_session() {
    SESSIONS.with(|sessions| {
        let mut sessions = sessions.borrow_mut();
        sessions.remove(&ic_cdk::api::caller());
    });
}

fn _cleanup_sessions() {
    let now =  (ic_cdk::api::time() / 1_000_000_000) as i64;

    SESSIONS.with(|sessions| {
        let mut sessions = sessions.borrow_mut();
        sessions.retain(|_, session| session.expires_at > now);
    });
}