import { createApp } from "vue";
import App from "./App.vue";
import { createPinia } from "pinia";
import { MotionPlugin } from "@vueuse/motion";
import "./index.css";
import router from "./router/";

const app = createApp(App);

app.use(MotionPlugin);
app.use(createPinia());
app.use(router);

app.mount("#root");
