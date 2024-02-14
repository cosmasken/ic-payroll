<template>
  <div class="space-y-2 ">
    <h1 class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">Transactions</h1>
    <p class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold">
      This is a list of all your transactions
    </p>
    <div 
    class=" p-2 "
    v-for="invoice in invoices" :key="transaction.id">

   
    <TransactionCard :sender="invoice.creator" :id="invoice.id" :receiver="invoice.payer"
    :amount="invoice.amount" 
    />
     </div>
   
  </div>
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";
import TransactionCard from "../components/TransactionCard.vue"
const authStore = useAuthStore();
let invoices = ref([]);


// watchEffect(async () => {
//   const res = await authStore.whoamiActor?.get_invoices();
//   invoices.value = await res;
// });


</script>
