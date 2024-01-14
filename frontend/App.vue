<template class="font-lexend">
  <main>
    <div v-if="isReady">
      <Home v-if="isAuthenticated" />
      <SignIn v-else />
    </div>
  </main>
</template>

<script setup>
import LoggedIn from "./components/LoggedIn.vue"
import Home from "./Home.vue"
import SignIn from "./components/auth/SignIn.vue"
import { storeToRefs } from "pinia"
import { useAuthStore } from "./store/auth"

const authStore = useAuthStore()
const { isReady, isAuthenticated } = storeToRefs(authStore)
if (isReady.value === false) {
  authStore.init()
}
</script>
