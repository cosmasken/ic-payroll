import { createApp } from "vue"
import App from "./App.vue"
import { createPinia } from "pinia"
import "./index.css"

import router from "./router/"

//createApp(App).use(createPinia()).mount("#root")
const app = createApp(App)

app.use(createPinia())
app.use(router)

app.mount("#root")
