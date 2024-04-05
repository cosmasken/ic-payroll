<template>
     
</template>
<script setup>
import { ref } from "vue";
import { useAuthStore } from "../store/auth";
const isLoading = ref(false);
const authStore = useAuthStore();
const registrationData = {
  wallet_address: "",
  employee_type: "",
  access_type: "",
};

</script>