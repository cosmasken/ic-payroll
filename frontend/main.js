import { createApp } from "vue";
import "./style.css";
import AuthGuard from "./AuthGuard.vue";
import { ethers } from "ethers";
import { createPinia } from "pinia";
import { MotionPlugin } from "@vueuse/motion";
import router from "./router/";

const app = createApp(AuthGuard);
app.use(MotionPlugin);
app.use(router);
app.use(ethers);
app.use(createPinia());

app.mount("#app");
