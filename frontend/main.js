import { createApp } from "vue";
import App from "./App.vue";
import { createPinia } from "pinia";
import "./index.css";
import Notifications from "vt-notifications";
//import Vue from "vue";

//Vue.use(Notifications);
import router from "./router/";

//createApp(App).use(createPinia()).mount("#root")
const app = createApp(App);

app.use(createPinia());
app.use(router);
//app.use(Notifications)

app.mount("#root");
