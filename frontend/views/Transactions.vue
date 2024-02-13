<template>
  <div>
    <h1 class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">Transactions</h1>
    <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">
      This is a list of all your transactions
    </p>
    <div 
    class="card p-2 bg-gray-300 space-y-2"
    v-for="transaction in transactions" :key="transaction.id">
      <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">ID: {{ transaction.id }}</p>
      <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">account: {{ transaction.creator }}</p>
      <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">RECEIVER: {{ transaction.destination }}</p>
      <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">AMOUNT: {{ transaction.amount }}</p>
      </div>
   
  </div>
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";
const authStore = useAuthStore();
let transactions = ref([]);


watchEffect(async () => {
  const res = await authStore.whoamiActor?.get_transactions();
  transactions.value = await res;
});


</script>
