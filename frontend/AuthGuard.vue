<script setup>
import router from "./router";
import SignIn from "./components/auth/SignIn.vue";
import { storeToRefs } from "pinia";
import { useAuthStore } from "./store/auth";
const authStore = useAuthStore();

const { isReady, isAuthenticated } = storeToRefs(authStore);
if (isReady.value === false) {
  authStore.init();
} else {
  //router.push("/home/dashboard");
  if (isAuthenticated.value === false) {
    router.push("/auth");
  } else {
    router.push("/setup-account");
  }
}
</script>
<template class="font-lexend">
  <main>
    <div v-if="isReady">
      <router-view v-if="isAuthenticated" />
      <SignIn v-else />
    </div>
    <div v-else>
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
  </main>
</template>
