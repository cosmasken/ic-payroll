import { defineStore } from "pinia"
import { AuthClient } from "@dfinity/auth-client"
import { createActor, canisterId } from "../../src/declarations/icrc1_ledger"
import { toRaw } from "vue"
import router from "../router"
import { IcrcLedgerCanister ,decodeIcrcAccount} from "@dfinity/ledger";
import { Principal } from "@dfinity/principal"



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
}

function actorFromIdentity(identity) {
  return createActor(
    canisterId, {
    agentOptions: {
      identity,
    },
  })
}

export const useledger = defineStore("ledger", {
  id: "ledger",
  state: () => {
    return {
      isReady: false,
      isAuthenticated : null,
      balance : null,
      metadata: null,
      authClient: null,
      identity: null,
      whoamiActor: null,
      ledger : null,
    }
  },
  actions: {
    async init() {
      const authClient = await AuthClient.create(defaultOptions.createOptions)
      this.authClient = authClient
      const isAuthenticated = await authClient.isAuthenticated()
      const identity = isAuthenticated ? authClient.getIdentity() : null
      const whoamiActor = identity ? actorFromIdentity(identity) : null

      const ledger = IcrcLedgerCanister.create({
        actorFromIdentity(identity),
        canisterId: "mxzaz-hqaaa-aaaar-qaada-cai",
      });

      this.ledger = await ledger;
      const data = await ledger.metadata({});
      console.log(data);
      this.metadata = data;      
      this.isAuthenticated = isAuthenticated
      this.identity = identity
      this.whoamiActor = whoamiActor
      this.isReady = true

     
    },
    async transfer (amount) {
      const transfer = await this.ledger.transfer({
        to: Principal.fromText("4l65c-5qman-4zmsj-c4pst-ym76w-ng2j3-n6b4i-2kqbm-ulxjx-plp2y-yqe"),
        amount: BigInt(10000000000),
      })
      console.log(transfer)
    }

    // async transfer(){
    //   //if authenticated
    //   if(this.isAuthenticated){
    //     //get the current balance
    //     const balance = await this.whoamiActor.getBalance()
    //     console.log(balance)
    //     //transfer 1000 cycles to the current user
    //     const transfer = await this.whoamiActor.transfer({
    //       to: Principal.fromText("ps3cf-rvqvv-thjw2-yolug-rssvn-2pzkl-bo5y3-bjg4n-eqn7c-wk3ko-5q"),
    //       amount: 1000,
    //     })
    //     console.log(transfer)
    //     //get the new balance
    //     const newBalance = await this.whoamiActor.getBalance()
    //     console.log(newBalance)
    //   }
    // }
   
  },

})
