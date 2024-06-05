import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import { Ed25519KeyIdentity } from '@dfinity/identity';
import { createActor, canisterId } from "../../src/declarations/backend";
import { toRaw ,markRaw } from "vue";
import Swal from "sweetalert2";
import { ethers } from 'ethers';
import { SiweMessage } from 'siwe';
import Web3 from 'web3';

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
};

const web3 = new Web3();

export const useAuthStore = defineStore("auth", {
  id: "auth",
  state: () => {
    return {
      isReady: false,
      isAuthenticated: null,
      isFirstLaunch: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      payments: null,
      departments: null,
      organizations: null,
      designations: null,
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
      authType: "internet-identity",
      message: null,
      domain: null,
      signature: null,
      siweIdentity: null,
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
      const siweIdentity = await Ed25519KeyIdentity.generate();
      const ethActor = siweIdentity ? actorFromIdentity(siweIdentity) : null;
    //  if (window.ethereum) {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
    
        this.provider = markRaw(provider);
        this.signer = markRaw(signer);
    //  }
       const domain = window.location.host;
     

      this.isAuthenticated = isAuthenticated;
      this.identity = identity;
      this.whoamiActor = whoamiActor;
      this.siweIdentity = siweIdentity;
      this.ethActor = ethActor;
       this.domain = domain;
      this.isReady = true;
      this.isRegistered = false;
    },

    async initSiwe() {


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

          this.isRegistered = await this.whoamiActor.isRegistered();
          console.log("is registered" + this.isRegistered);
        },
      });
    },

    async connect2ic() {

    },

    async requestAccounts() {
      try {
        // Request account access
        const accounts = await ethereum.request({ method: 'eth_requestAccounts' });
        console.log('Accounts:', accounts);
        
        // Assuming the first account is used for signing
        const account = accounts[0];
    
        // The message you want to sign
        const message = 'Hello, Do you want to sign in to IC-PAY?';
    
        // Hash the message (optional but recommended)
       // const messageHash = web3.utils.sha3(message);
    
        // Sign the hashed message
        const signature = await ethereum.request({
          method: 'personal_sign',
          params: [message, account]
        });
    
        console.log('Signature:', signature);
      } catch (error) {
        console.error('Error requesting accounts or signing message:', error);
      }
    },
    
    // Call the function
   // requestAccounts();
    
    async connectWallet() {
      const ethereum = window.ethereum
      if (!ethereum) {
        Swal.fire({
          title: "Good job!",
          text: "MetaMask is not installed! Please install it to your extensions for connect your wallet.",
          icon: "error"
        });
        // return toast.error(
        //   'MetaMask is not installed! Please install it to your extensions for connect your wallet.'
        // )
      } else {
        const res = await ethereum.request({ method: 'eth_requestAccounts' })
        this.ethAddress = res[0]
        console.log('address', this.ethAddress)
        Swal.fire({
          title: "Good job!",
          text: "You clicked the button!",
          icon: "success"
        });
      }
    },
    async signInWithEthereum() {
    //  const  statement = 'Sign in with Ethereum';
    
    //   const www = this.siweIdentity.getPrincipal();
    
    // const  message = createSiweMessage(
    //     this.domain,
    //     await this.signer.getAddress(),
    //     'Sign in with Ethereum',
    //     'did:icp:' + "this.siweIdentity.getPrincipal()",
    //     ['icp:' + canisterId],
    //   );

    //   console.log('message', message);
    
    //   const signature = await this.signer.signMessage(message);
    
    //  // agent = Actor.agentOf(backend);
    //  // agent.replaceIdentity(identity);
     this.isAuthenticated = true;
     console.log('Successfully signed in!');
    
    },
    

    async getBalance() {
      // const whoamiActor = toRaw(this.whoamiActor);
      const balance = await whoamiActor.getTradingBalance();
      this.tradingbalance = await balance;
    },

    async decodeAddress(){
//pseudocode for decoding address
//       decodeAccount(text) = case Principal.fromText(text) of
//   | (prefix · [n, 0x7f]) where Blob.size(prefix) < n ⇒ raise Error
//   | (prefix · [n, 0x7f]) where n > 32 orelse n = 0 ⇒ raise Error
//   | (prefix · suffix · [n, 0x7f]) where Blob.size(suffix) = n ⇒
//     if suffix[0] = 0
//     then raise Error
//     else { owner = Principal.fromBlob(prefix); subaccount = Some(expand(suffix)) }
//   | raw_bytes ⇒ { owner = Principal.fromBlob(raw_bytes); subaccount = None }

// expand(bytes) = if Blob.size(bytes) < 32
//                 then expand(0x00 :: bytes)
//                 else bytes


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
    async update_user(firstname, lastname, email, phone) {
      const response = await this.whoamiActor?.updateUser({
        first_name: firstname,
        last_name :lastname,
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
          icon: "success"
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
      console.log("test");
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

      console.log("test");
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
