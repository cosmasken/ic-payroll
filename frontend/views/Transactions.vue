<template>
  <div class="space-y-2 ">
    <h1 class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">Transactions</h1>
    <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">
      This is a list of all your transactions
    </p>
    <div 
    class=" p-2 "
    v-for="transaction in transactions" :key="transaction.id">

   
    <TransactionCard :sender="transaction.creator" :id="transaction.id" :receiver="transaction.destination"
    :amount="transaction.amount"  
    />
     </div>
   
  </div>
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";
import TransactionCard from "../components/TransactionCard.vue"
const authStore = useAuthStore();
let transactions = ref([]);


watchEffect(async () => {
  const res = await authStore.whoamiActor?.get_transactions();
  transactions.value = await res;
});


</script>
