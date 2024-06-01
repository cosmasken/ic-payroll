//import { ic_siwe_provider } from "../../src/declarations/ic_siwe_provider/ic_siwe_provider.did";
import { defineStore } from "pinia";
//import { canisterId, createActor } from '../../src/declarations/ic_siwe_provider/ic_siwe_provider.did';


// function actorFromIdentity() {
//   return createActor(canisterId, {
//   });
// };
export const useEthStore = defineStore("ethAuth", {
  id: "ethAuth",
  state: () => {
    return {
      identity: null,
      address : null,
      isReady: false,
      isAuthenticated: null,
      authClient :null,
      whoamiActor: null,
    };
  },
  actions: {

    async connect () {
      console.log("Logging in"); 
    },

    login() { 
      this.isReady = true;
      this.isAuthenticated = true;
      console.log("Logging in");
    },
    getAddress(){
     // const whoamiActor = actorFromIdentity();
     // this.whoamiActor = whoamiActor;
      console.log("Getting address");
     // this.whoamiActor.getAddress();

    }
    

  },
  getters: {},
});
