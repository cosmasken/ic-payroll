import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
//import { createActor, canisterId } from "../../src/declarations/backend"
import { createActor, canisterId } from "../../src/declarations/backend";
import { toRaw } from "vue";
import Swal from "sweetalert2";

const useUpload = defineStore('upload', () => {
 id: 'upload',
    state: () => {
        return {
            uploads: [],
            upload: null,
            uploadError: null,
            uploadSuccess: null,
            uploadLoading: false,
        };
    },
    actions: {
    },
    getters: {
        
    }
  });


//   import { defineStore } from "pinia";
// import { AuthClient } from "@dfinity/auth-client";
// import { createActor, canisterId } from "../../src/declarations/backend";
// import { toRaw } from "vue";
// import { ethers } from 'ethers';
// import { ref } from "vue";
// import { Actor } from '@dfinity/agent';
// import { Ed25519KeyIdentity } from '@dfinity/identity';
// import { useMetaMaskWallet } from "vue-connect-wallet";
// import { SiweMessage } from 'siwe';
// import { siwe_ic, canisterId as canID  } from "../../src/declarations/siwe_ic";
// import { Principal } from "@dfinity/principal";

// const address = ref("");
// const principal = ref("");
// const wallet = useMetaMaskWallet();






// const isConnected = async () => {
//   const accounts = await wallet.getAccounts();
//   if (typeof accounts === "string") return false;
//   return accounts.length > 0;
// };



// const defaultOptions = {
//   /**
//    *  @type {import("@dfinity/auth-client").AuthClientCreateOptions}
//    */
//   createOptions: {
//     idleOptions: {
//       // Set to true if you do not want idle functionality
//       disableIdle: true,
//     },
//   },
//   /**
//    * @type {import("@dfinity/auth-client").AuthClientLoginOptions}
//    */
//   loginOptions: {
//     identityProvider:
//       process.env.DFX_NETWORK === "ic"
//         ? "https://identity.ic0.app/#authorize"
//         : `http://b77ix-eeaaa-aaaaa-qaada-cai.localhost:4943`,
//   },
// };


// function actorFromIdentity(identity) {
//   return createActor(canisterId, {
//     agentOptions: {
//       identity,
//     },
//   });
// }

// function actorFromEthIdentity(identity) {
//   return createActor(canId, {
//     agentOptions: {
//       identity,
//     },
//   });
// }
// export const useAuthStore = defineStore("auth", {
//   id: "auth",
//   state: () => {
//     return {
//       isReady: false,
//       isAuthenticated: null,
//       authClient: null,
//       identity: null,
//       whoamiActor: null,
//       payments: null,
//       registrationData: {},
//       transferArgs: {},
//       requestArgs: {},
//       tradingbalance: null,
//       fundingbalance: null,
//       fundingaddress: null,
//       ethaddress: null,
//       canisteraddress: null,
//       tradingaddress: null,
//       canisterbalance: null,
//       notifications: [],
//       isRegistered: null,
//       userInfo: null,
//       transactions: [],
//       authType: "internet-identity",
//       provider:null,
//       agent:null,
//       signer:null,
//       wallet:null,
//     };
//   },
//   actions: {
//     async init() {
//         // const authClient = await AuthClient.create(defaultOptions.createOptions);
//         // this.authClient = authClient;
//         // const isAuthenticated = await authClient.isAuthenticated();
//         // const identity = isAuthenticated ? authClient.getIdentity() : null;
//         // const whoamiActor = identity ? actorFromIdentity(identity) : null;       
        
//         // this.isAuthenticated = isAuthenticated;
//         // this.identity = identity;
//         // this.whoamiActor = whoamiActor;
//         // this.isReady = true;
//         // this.isRegistered = false;
//         if (this.authType === "internet-identity"){
//           const authClient = await AuthClient.create(defaultOptions.createOptions);
//           this.authClient = authClient;
//           const isAuthenticated = await authClient.isAuthenticated();
//           const identity = isAuthenticated ? authClient.getIdentity() : null;
//           const whoamiActor = identity ? actorFromIdentity(identity) : null;

//           console.log('internet-identity' + whoamiActor);
  
//           this.isAuthenticated = isAuthenticated;
//           this.identity = identity;
//           this.whoamiActor = whoamiActor;
//           this.isReady = true;
//           this.isRegistered = false;
//         }else if(this.authType === "connect2ic"){
//           this.isReady = true;
//           this.isRegistered = false;
//         }else if(this.authType === "siwe"){
//           const wallet = useMetaMaskWallet();
//           const accounts = await wallet.getAccounts();
//           const isAuthenticated = async () => {  
//             return Array.isArray(accounts) && accounts.length > 0;
//           };
//           const identity = isAuthenticated ? Ed25519KeyIdentity.generate() : null;
//           const whoamiActor = identity ? actorFromIdentity(identity) : null;

//           console.log('siwe' + whoamiActor);

//           this.isAuthenticated = isAuthenticated;
//           this.identity = identity;
//           this.whoamiActor = whoamiActor;
//           this.isReady = true;
//           this.isRegistered = false;
//         }
      

//     },
//     async login() {
//       const authClient = toRaw(this.authClient);

//       authClient.login({
//         ...defaultOptions.loginOptions,
//         maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000000),
//         onSuccess: async () => {
//           this.isAuthenticated = await authClient.isAuthenticated();
//           this.identity = this.isAuthenticated
//             ? authClient.getIdentity()
//             : null;
//           this.whoamiActor = this.identity
//             ? actorFromIdentity(this.identity)
//             : null;

//           this.isRegistered = await this.whoamiActor.isRegistered();
//           console.log("is registered" + this.isRegistered);
//         },
//       });
//     },

//     async connect2ic() {},
   
//     async  connect () {
//       const accounts = await wallet.connect();
//       if (typeof accounts === "string") {
//         console.log("An error occurred" + accounts);
//       }

//       console.log('accounts' + accounts)
    
//        const statement = 'Sign in with Ethereum';
//        const identity = await Ed25519KeyIdentity.generate();
//        principal.value = identity.getPrincipal();
//        console.log('identity' + identity.getPrincipal());
       
//       address.value = accounts[0];
//       console.log("Connected to account: ", accounts[0]);
//     },
//     async switchAccount () {
//       await wallet.switchAccounts();
//       await this.connect();
//     },

//     async getBalance() {
//       // const whoamiActor = toRaw(this.whoamiActor);
//       const balance = await whoamiActor.getTradingBalance();
//       this.tradingbalance = await balance;
//     },


//     async refresh() {
//       //const whoamiActor = toRaw(this.whoamiActor);
//       const fundingbalance = await this.whoamiActor.getFundingBalance();
//       const tradingbalance = await this.whoamiActor.getTradingBalance();
//       const fundingaddress = await this.whoamiActor.getFundingAddress();
//       const tradingaddress = await this.whoamiActor.getTradingAddress();
//       const canisteraddress = await this.whoamiActor.getCanisterAddress();
//       const canisterbalance = await this.whoamiActor.getCanisterBalance();
//       const notifications = await this.whoamiActor.getNotifications();
//       const registered = await this.whoamiActor.isRegistered();
//       this.fundingbalance = await fundingbalance;
//       this.tradingbalance = await tradingbalance;
//       this.fundingaddress = await fundingaddress;
//       this.canisteraddress = await canisteraddress;
//       this.canisterbalance = await canisterbalance;
//       this.tradingaddress = await tradingaddress;
//       this.isRegistered = await registered;
//     },
//     async logout() {
//       const authClient = toRaw(this.authClient);
//       await authClient?.logout();
//       this.isAuthenticated = false;
//       this.identity = null;
//       this.whoamiActor = null;
//     },
   
//     async siwelogout(){
//       await siwe.clear_session();
//     },
//     updateRegistrationData(data) {
//       this.registrationData = { ...this.registrationData, ...data };
//     },

//     updateTranferArgs(data) {
//       this.transferArgs = { ...this.transferArgs, ...data };
//     },

//     clearRegistrationData() {
//       this.registrationData = {};
//     },

//     clearTransferArgs() {
//       this.transferArgs = {};
//     },

//     setUserInfo(userInfo) {
//       this.userInfo = userInfo;
//     },
//     async update_user(firstname, lastname, email, phone) {
//       const response = await this.whoamiActor?.updateUser({
//         name: firstname + " " + lastname,
//         email_address: email,
//         phone_number: phone,
//         email_notifications: true,
//         phone_notifications: true,
//       });
//       console.log(response);
//       if (response.status === 200) {
//         console.log(" user registered");
//         console.log(response);
//         this.isRegistered = true;
//       }

//       console.log(response);
//     },

//     async create_employee(wallet,emp_type,access_type) {
//       const dataToSend = {
//         emp_type: {emp_type},
//         access_type: {access_type}
//       };
//       console.log("dataToSend"+dataToSend);
      
//       const response = await this.whoamiActor?.create_employee({
//         wallet: wallet,
//         emp_type: emp_type,
//         access_type: access_type
//       });

//       console.log("auth"+response);
//       if (response.status === 200) {
//         console.log(" employee registered");
//         console.log(response);
//       }
//     },

//     async remove_employee(wallet) {
//       const response = await this.whoamiActor?.remove_employee({
//         wallet: wallet,
//       });

//       console.log(response);
//     },

//     async createInvoice(amount, payer) {
//       const response = await this.whoamiActor?.create_invoice({
//         amount: amount,
//         payer: payer,
//       });

//       console.log(response);
//     },
//   },
//   getters: {
//     registrationStatus(state) {
//       return state.isRegistered;
//     },
//   },
// });