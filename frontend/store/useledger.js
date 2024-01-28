import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import { createActor, canisterId } from "../../src/declarations/backend";
import { IcrcLedgerCanister } from "@dfinity/ledger-icrc";
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

export const useledger = defineStore("ledger", {
  id: "ledger",
  state: () => {
    return {
      isReady: false,
      isAuthenticated: null,
      balance: null,
      metadata: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      ledger: null,
    };
  },
  actions: {
    async init() {
      const authClient = await AuthClient.create(defaultOptions.createOptions);
      this.authClient = authClient;
      const isAuthenticated = await authClient.isAuthenticated();
      const identity = isAuthenticated ? authClient.getIdentity() : null;
      const whoamiActor = identity ? actorFromIdentity(identity) : null;

      const ledger = IcrcLedgerCanister.create({
        agent: whoamiActor,
        canisterId: "mxzaz-hqaaa-aaaar-qaada-cai",
      });

      this.ledger = await ledger;
      const balance = await ledger.totalTokensSupply({
        certified: false,
      });
      // const data = await ledger.metadata({});
      console.log("totaltokensupply is ", balance);
      this.balance = balance;
      this.isAuthenticated = isAuthenticated;
      this.identity = identity;
      this.whoamiActor = whoamiActor;
      this.isReady = true;
    },
  },
});
