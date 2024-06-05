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
// import { defineStore } from 'pinia'
// import { ref, reactive, computed } from 'vue'
// import Web3 from 'web3'

// export const useEthStore = defineStore('auth', () => {
//   const user = reactive({
//     wallet: '',
//     balance: 0,
//   })

//   const isLoaded = ref(false)
//   const showMessage = ref(true)

//   const auth = async () => {
//     if (window.ethereum) {
//       window.web3 = new Web3(window.ethereum)
//       try {
//         window.ethereum.enable().then(() => {
//           console.log('MetaMask connected!')
//           authenticate()
//         })
//       } catch (e) {
//         console.log('User denied account access')
//       }
//     } else {
//       alert(
//         'You must have a Meta Mask wallet in your browser. Please install it in your Google Chrome.'
//       )
//     }
//   }

//   const authenticate = async () => {
//     const accounts = await window.web3.eth.getAccounts()

//     const address = accounts[0]
//     user.wallet = address

//     const balance = await window.web3.eth.getBalance(user.wallet)
//     user.balance = balance

//     isLoaded.value = true

//     setTimeout(() => {
//       showMessage.value = false
//     }, 2000)
//   }

//   const walletCropped = computed(
//     () => `${user.wallet.slice(0, 4)}...${user.wallet.slice(-3)}`
//   )
//   const balanceRounded = computed(() => (user.balance / 1e18).toFixed(4))

//   return {
//     user,
//     isLoaded,
//     showMessage,
//     auth,
//     authenticate,
//     walletCropped,
//     balanceRounded,
//   }
// })