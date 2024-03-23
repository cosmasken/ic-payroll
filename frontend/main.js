import { createApp } from "vue";
import App from "./App.vue";
import { createPinia } from "pinia";
import { MotionPlugin } from "@vueuse/motion";
import "./index.css";
//import Vue from "vue";

//Vue.use(Notifications);
import router from "./router/";

//createApp(App).use(createPinia()).mount("#root")
const app = createApp(App);

app.use(MotionPlugin);
app.use(createPinia());
app.use(router);
//app.use(Notifications)

app.mount("#root");
