import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import * as asn1js from "asn1js";
import { toChecksumAddress } from "ethereumjs-util";
import { Ed25519KeyIdentity } from "@dfinity/identity";
import { createActor, canisterId } from "../../src/declarations/backend";
import { ic_siwe_provider } from "../../src/declarations/ic_siwe_provider";
import { toRaw, markRaw } from "vue";
import Swal from "sweetalert2";
import Web3 from "web3";

const defaultOptions = {
  /**
   *  @type {import("@dfinity/auth-client").AuthClientCreateOptions}
   */
  createOptions: {
    idleOptions: {
      // Set to true if you do not want idle functionality
      disableIdle: true,
    },
  },
  /**
   * @type {import("@dfinity/auth-client").AuthClientLoginOptions}
   */
  loginOptions: {
    identityProvider:
      process.env.DFX_NETWORK === "ic"
        ? "https://identity.ic0.app/#authorize"
        : `http://b77ix-eeaaa-aaaaa-qaada-cai.localhost:4943`,
  },
  // loginOptions:{
  //   identityProvider : "https://identity.ic0.app/#authorize"
  // }
};

function actorFromIdentity(identity) {
  return createActor(canisterId, {
    agentOptions: {
      identity,
    },
  });
}

export const useAuthStore = defineStore("auth", {
  id: "auth",
  state: () => {
    return {
      isReady: false,
      isRefreshing: false,
      isAuthenticated: null,
      isFirstLaunch: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      payments: null,
      registrationData: {},
      transferArgs: {},
      requestArgs: {},
      tradingbalance: null,
      fundingbalance: null,
      fundingaddress: null,
      canisteraddress: null,
      tradingaddress: null,
      canisterbalance: null,
      notifications: [],
      isRegistered: null,
      userInfo: null,
      transactions: [],
      ethActor: null,
      signer: null,
      provider: null,
      ethAddress: null,
    };
  },
  actions: {
    async init() {
      const authClient = await AuthClient.create(defaultOptions.createOptions);
      this.authClient = authClient;
      const isAuthenticated = await authClient.isAuthenticated();
      const identity = isAuthenticated ? authClient.getIdentity() : null;
      const whoamiActor = identity ? actorFromIdentity(identity) : null;
      this.isAuthenticated = isAuthenticated;
      this.identity = identity;
      this.whoamiActor = whoamiActor;
      this.isReady = true;
      this.isRegistered = false;
    },

    async login() {
      const authClient = toRaw(this.authClient);

      authClient.login({
        ...defaultOptions.loginOptions,
        maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000000),
        onSuccess: async () => {
          this.isAuthenticated = await authClient.isAuthenticated();
          this.identity = this.isAuthenticated
            ? authClient.getIdentity()
            : null;
          this.whoamiActor = this.identity
            ? actorFromIdentity(this.identity)
            : null;

          console.log("whoamiActor", this.whoamiActor);

          this.isRegistered = await this.whoamiActor.isRegistered();
          console.log("is registered" + this.isRegistered);
        },
      });
    },

    async requestAccounts() {
      // Check if there are any accounts already connected
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log("Accounts:", accounts);
      // Assuming the first account is used for signing
      const account = accounts[0];
      // The message you want to sign
      const message = "Sign In to IC-Pay";
      // Hash the message (optional but recommended)
      // const messageHash = web3.utils.sha3(message);
      // Convert the message to hex format
      const msgHex = `0x${Buffer.from(message, "utf8").toString("hex")}`;
      // Sign the hashed message
      const signature = await ethereum.request({
        method: "personal_sign",
        params: [msgHex, account], // Note the correct order of parameters
      });

      console.log("Signature:", signature);
      //generate identity
      const identity = Ed25519KeyIdentity.generate();
      //create whoami actor
      const whoamiActor = identity ? actorFromIdentity(identity) : null;

      this.isAuthenticated = true;
      this.identity = identity;
      this.whoamiActor = whoamiActor;
      this.isReady = true;
      this.isRegistered = false;

      const principal = identity.getPrincipal();

      const addToMetamaskUsers = await this.whoamiActor?.addToMetamaskUsers(
        account,
        principal
      );

      console.log("addToMetamaskUsers:", addToMetamaskUsers);
      //  this.isRegistered = await whoamiActor?.isRegistered();
      console.log("is registered" + this.isRegistered);
    },

    async siwe_ic() {
      try {
        // Check if there are any accounts already connected
        const accounts = await ethereum.request({
          method: "eth_requestAccounts",
        });
        // Get the first account and ensure it is EIP-55 encoded
        let account = Web3.utils.toChecksumAddress(accounts[0]);
        // Prepare the login challenge
        const prepareLoginResponse = await ic_siwe_provider.siwe_prepare_login(account);
        const loginChallenge = prepareLoginResponse.Ok;

        // Sign the login challenge
        const signature = await ethereum.request({
          method: "personal_sign",
          params: [loginChallenge, account],
        });

        // Prepare a dummy session key for demonstration purposes
        const sessionKey = new Uint8Array([67]);
        //use asn1js to generate a DER-encoded OctetString
        const derSessionKey = new asn1js.OctetString({
          valueHex: sessionKey,
        }).toBER(false);
        // Convert the DER-encoded ArrayBuffer to a Uint8Array
        const derSessionKeyUint8 = new Uint8Array(derSessionKey);

        // Log in with the signed challenge and session key
        const loginResponse = await ic_siwe_provider.siwe_login(
          signature,
          account,
          derSessionKeyUint8
        );
        console.log("Login response:", loginResponse);
        //get principal

        const principal = await ic_siwe_provider.get_principal(account);
        console.log("Principal:", principal);
        // Get the current timestamp in milliseconds
        const currentTimestamp = Date.now();
        // Convert the timestamp to a BigInt
        const nat64Timestamp = BigInt(currentTimestamp);

     //   const pubkey = loginResponse.Ok.user_canister_pubkey;
       // const expiration = loginResponse.Ok.expiration;
        // const delegation = await ic_siwe_provider.siwe_get_delegation(
        //   account,
        //   pubkey,
        //   expiration
        // );
     //   console.log("Delegation:", delegation);

        if (loginResponse.Ok) {
          console.log("Login successful");
          this.isAuthenticated = true;
          this.isReady = true;
        }

      } catch (error) {
        console.error("Error during login:", error);
      }
    },



    async siwe() {
      //generate identity
      const identity = Ed25519KeyIdentity.generate();
      //create whoami actor
      const whoamiActor = identity ? actorFromIdentity(identity) : null;
      // Check if there are any accounts already connected
      const accounts = await ethereum.request({
        method: "eth_requestAccounts",
      });
      console.log("Accounts:", accounts);
      // Assuming the first account is used for signing
      const account = accounts[0];
      // The message you want to sign
      const message = "Sign In to IC-Pay";
      const msgHex = `0x${Buffer.from(message, "utf8").toString("hex")}`;
      const signature = await ethereum.request({
        method: "personal_sign",
        params: [msgHex, account], // Note the correct order of parameters
      });

      //check if address is already registered
      const isRegistered = await whoamiActor?.getPrincipalByAddress(account);

      if (isRegistered) {
        this.isAuthenticated = true;
        this.identity = identity;
        this.whoamiActor = whoamiActor;
        this.isReady = true;
        this.isRegistered = false;
        console.log("already registered");
      } else {
        const principal = identity.getPrincipal();
        const addToMetamaskUsers = await this.whoamiActor?.addToMetamaskUsers(
          account,
          principal
        );
        this.isAuthenticated = true;
        this.identity = identity;
        this.whoamiActor = whoamiActor;
        this.isReady = true;
        this.isRegistered = false;
        console.log("addedToMetamaskUsers:", principal);
        console.log("identity", identity);
      }
    },

    async prepareLogin() {
      const prep = await ic_siwe_provider.siwe_prepare_login();
      console.log("prep", prep);
    },

    async getBalance() {
      // const whoamiActor = toRaw(this.whoamiActor);
      const balance = await whoamiActor.getTradingBalance();
      this.tradingbalance = await balance;
    },

    async refresh() {
      //const whoamiActor = toRaw(this.whoamiActor);
      const fundingbalance = await this.whoamiActor.getFundingBalance();
      const tradingbalance = await this.whoamiActor.getTradingBalance();
      const fundingaddress = await this.whoamiActor.getFundingAddress();
      const tradingaddress = await this.whoamiActor.getTradingAddress();
      const canisteraddress = await this.whoamiActor.getCanisterAddress();
      const canisterbalance = await this.whoamiActor.getCanisterBalance();
      const notifications = await this.whoamiActor.getNotifications();
      const registered = await this.whoamiActor.isRegistered();
      this.fundingbalance = await fundingbalance;
      this.tradingbalance = await tradingbalance;
      this.fundingaddress = await fundingaddress;
      this.canisteraddress = await canisteraddress;
      this.canisterbalance = await canisterbalance;
      this.tradingaddress = await tradingaddress;
      this.isRegistered = await registered;
    },
    async logout() {
      const authClient = toRaw(this.authClient);
      await authClient?.logout();
      this.isAuthenticated = false;
      this.identity = null;
      this.whoamiActor = null;
    },

    async siwelogout() {
      await siwe.clear_session();
    },
    updateRegistrationData(data) {
      this.registrationData = { ...this.registrationData, ...data };
    },

    updateOrganizations(data) {
      this.organizations = data;
      console.log("organizations", this.organizations);
    },

    updateTranferArgs(data) {
      this.transferArgs = { ...this.transferArgs, ...data };
    },

    clearRegistrationData() {
      this.registrationData = {};
    },

    clearTransferArgs() {
      this.transferArgs = {};
    },

    setUserInfo(userInfo) {
      this.userInfo = userInfo;
    },
    async update_user(principal, firstname, lastname, email, phone) {
      const response = await this.whoamiActor?.updateUser({
        principal: principal,
        first_name: firstname,
        last_name: lastname,
        email_address: email,
        phone_number: phone,
        email_notifications: true,
        phone_notifications: true,
      });
      console.log(response);
      if (response.status === 200) {
        Swal.fire({
          title: "Good job!",
          text: "You completed your profile!",
          icon: "success",
        });
        console.log(" user registered");
        console.log(response);
        this.isRegistered = true;
      }

      console.log(response);
    },

    async create_employee(wallet, emp_type, access_type) {
      const dataToSend = {
        emp_type: { emp_type },
        access_type: { access_type },
      };
      console.log("dataToSend" + dataToSend);

      const response = await this.whoamiActor?.create_employee({
        wallet: wallet,
        emp_type: emp_type,
        access_type: access_type,
      });

      console.log("auth" + response);
      if (response.status === 200) {
        console.log("employee registered");
        console.log(response);
      }
    },
    async create_organization(name) {
      const response = await this.whoamiActor?.create_organization({
        code: code,
        name: name,
      });

      if (response.status === 200) {
        console.log(" organization registered");
        console.log(response);
      }
    },
    async create_department(name) {
      const response = await this.whoamiActor?.create_department({
        code: code,
        name: name,
      });

      if (response.status === 200) {
        console.log(" organization registered");
        console.log(response);
      }
      return response;
    },
    async create_designation(name) {
      const response = await this.whoamiActor?.create_designation({
        code: code,
        name: name,
      });

      console.log("organization" + response);
      if (response.status === 200) {
        console.log(" organization registered");
        console.log(response);
      }
    },

    async remove_employee(wallet) {
      const response = await this.whoamiActor?.remove_employee({
        wallet: wallet,
      });

      console.log(response);
    },

    async createInvoice(amount, payer) {
      const response = await this.whoamiActor?.create_invoice({
        amount: amount,
        payer: payer,
      });

      console.log(response);
    },
  },
  getters: {
    registrationStatus(state) {
      return state.isRegistered;
    },
  },
});
