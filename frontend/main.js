import { createApp } from "vue"
import App from "./App.vue"
import { createPinia } from "pinia"
import "./index.css"

createApp(App).use(createPinia()).mount("#root")
