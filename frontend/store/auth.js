import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import {HttpAgent} from '@dfinity/agent';
import { createActor, canisterId } from "../../src/declarations/backend";
import { toRaw } from "vue";
import Swal from "sweetalert2";

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

          this.isRegistered = await this.whoamiActor.isRegistered();
          console.log("is registered" + this.isRegistered);
        },
      });
    },

    async connect2ic() {},
    async siwe() {
      // const { login, clear, identity } = useSiweIdentity();
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
