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

export const useAuthStore = defineStore("auth", {
  id: "auth",
  state: () => {
    return {
      isReady: false,
      isIndivual: false,
      isAuthenticated: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      accountAddress: null,
      currentBalanceBaseUnits: null,
      createdCount: null,
      payments: null,
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

          // router.push("/home/dashboard")
        },
      });
    },
    async logout() {
      const authClient = toRaw(this.authClient);
      await authClient?.logout();
      this.isAuthenticated = false;
      this.identity = null;
      this.whoamiActor = null;
    },
  },
});
