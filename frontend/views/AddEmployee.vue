<template>
  <div>
    <div v-if="isLoading === true">
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
    <div v-else>
      <Navbar/>
      <router-view></router-view>
    </div>
  </div>
</template>

<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../store/auth";
import router from "../router/";
import Navbar from "../components/Navbar.vue";
const isLoading = ref(false);
const authStore = useAuthStore();

//get currEnt time to int
const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};

const registrationData = {
  wallet_address: "",
};
const addData = async () => {
  isLoading.value = true;
  authStore.updateRegistrationData(registrationData);
  const address = authStore.registrationData.wallet_address;

  console.log(address);

  try {
    const response = authStore.create_employee(
      address
    );
    await new Promise((resolve) => setTimeout(resolve, 5000));
  } catch (error) {
    console.error("Error submitting data:", error);
  } finally {
    isLoading.value = false;
    console.error("Successful:");
    router.push("/home/dashboard");
  }
};
</script>
