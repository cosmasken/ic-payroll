<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
let organizationsArray = ref([]);
const isLoading = ref(false);
</script>
<template>
  <div class="flex flex-row justify-between">
    <div class="flex flex-col">
      <p class="text-lg text-black">VCF</p>
    </div>
    <div class="flex flex-col justify-center">
      <p class="text-autom8-blue-600 cursor-pointer">Download</p>
    </div>
  </div>
</template>
