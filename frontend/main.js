import { createApp } from "vue";
import "./style.css";
import AuthGuard from "./AuthGuard.vue";
import { ethers } from "ethers";
import { createPinia } from "pinia";
import { MotionPlugin } from "@vueuse/motion";
<<<<<<< HEAD
import "./index.css";
import "vue-connect-wallet/dist/style.css";
=======
>>>>>>> workingpoint
import router from "./router/";
import { providers } from 'ethers';
//import { SiweIdentityProvider } from 'ic-use-siwe-identity';




const app = createApp(AuthGuard);

app.use(MotionPlugin);
app.use(router);
app.use(ethers);
//app.use(SiweIdentityProvider, { canisterId, idlFactory });
app.use(createPinia());
//app.use(VagmiPlugin(client));

app.mount("#app");
