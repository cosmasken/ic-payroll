import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
//import { createActor, canisterId } from "../../src/declarations/backend"
import { createActor, canisterId } from "../../src/declarations/backend";
import { toRaw } from "vue";
import router from "../router";
import { Principal } from "@dfinity/principal";

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
        : `http://rdmx6-jaaaa-aaaaa-aaadq-cai.localhost:4943`,
  },
};

function actorFromIdentity(identity) {
  return createActor(canisterId, {
    agentOptions: {
      identity,
    },
  });
}

const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};

function formatCkBtc(amount) {
  if (amount === undefined) return "0";
  amount = typeof amount === "number" ? BigInt(amount) : amount;
  if (!amount) return "0";
  const integerPart = amount / 100000000n;
  const fractionalPart = amount % 100000000n;
  const fractionalPartString = fractionalPart.toString().padStart(8, "0");
  const fractionalPartTrimmed = fractionalPartString.replace(/0+$/, ""); // Removes trailing zeroes
  return `${integerPart.toLocaleString()}.${fractionalPartTrimmed}`;
};

export const useAuthStore = defineStore("auth", {
  id: "auth",
  state: () => {
    return {
      isReady: false,
      isAuthenticated: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      payments: null,
      registrationData: {},
      transferArgs: {},
      tradingbalance: null,
      fundingbalance: null,
      fundingaddress: null,
      canisteraddress: null,
      canisterbalance: null,
      isConfigured: null,
      userInfo: null,
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
      this.isConfigured = false;
    },
    async login() {
      const authClient = toRaw(this.authClient);

      authClient.login({
        ...defaultOptions.loginOptions,
        maxTimeToLive: BigInt(7 * 24 * 60 * 60 * 1000 * 1000 * 1000),
        onSuccess: async () => {
          this.isAuthenticated = await authClient.isAuthenticated();
          this.identity = this.isAuthenticated
            ? authClient.getIdentity()
            : null;
          this.whoamiActor = this.identity
            ? actorFromIdentity(this.identity)
            : null;
        },
      });
    },

    async getBalance() {
      // const whoamiActor = toRaw(this.whoamiActor);
      const balance = await whoamiActor.getTradingBalance();
      this.balance = await balance;
    },

    async refresh() {
      //const whoamiActor = toRaw(this.whoamiActor);
      const fundingbalance = await this.whoamiActor.getFundingBalance();
      const tradingbalance = await this.whoamiActor.getTradingBalance();
      const fundingaddress = await this.whoamiActor.getFundingAddress();
      const canisteraddress = await this.whoamiActor.getCanisterAddress();
      const canisterbalance = await this.whoamiActor.getCanisterBalance();
      const config = await this.whoamiActor.userExists();
      this.fundingbalance = await fundingbalance;
      this.tradingbalance = await tradingbalance;
      this.fundingaddress = await fundingaddress;
      this.canisteraddress = await canisteraddress;
      this.canisterbalance = await canisterbalance;
      this.isConfigured = await config;
    },
    async logout() {
      const authClient = toRaw(this.authClient);
      await authClient?.logout();
      this.isAuthenticated = false;
      this.identity = null;
      this.whoamiActor = null;
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
    async registration(firstname, lastname, email, phone, wallet) {
      const response = await this.whoamiActor?.create_employee({
        name: firstname + " " + lastname,
        email: email,
        phone_number: phone,
        wallet : wallet
      });
      if (response.status === 200) {
        console.log(" employee registered");
         console.log(response);
      }

      console.log(response);
    },
  },
  getters: {
    getConfiguration(state) {
      return state.isConfigured;
    },
  },
});
