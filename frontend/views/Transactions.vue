<template>
  <div class="space-y-2 p-5">
    <h1 class="text-3xl text-[#16151C] dark:text-white font-semibold ">
        Transaction History 
      </h1>
    
    <div class="p-2" v-for="transaction in transactions" :key="transaction.id">
      <TransactionCard
        :sender="transaction.creator"
        :id="transaction.id"
        :receiver="transaction.destination"
        :amount="transaction.amount"
      />
    </div>
  </div>
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";
import TransactionCard from "../components/TransactionCard.vue";
const authStore = useAuthStore();
let transactions = ref([]);

watchEffect(async () => {
  const res = await authStore.whoamiActor?.get_transactions();
  transactions.value = await res;
});
</script>
