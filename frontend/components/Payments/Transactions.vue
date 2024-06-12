<template>
  <!--div class="space-y-2 p-5">
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
    </div-->

  <main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div class="mb-6">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Transaction History
      </h2>
      <p class="text-sm sm:text-base text-gray-500 font-normal">
        Your current Transaction History
      </p>
    </div>

    <div class="p-2" v-for="transaction in transactions" :key="transaction.id">
      <TransactionCard
        :sender="transaction.creator"
        :id="transaction.id"
        :receiver="transaction.destination"
        :amount="transaction.amount"
      />
    </div>
  </main>
</template>
<script setup>
import { useAuthStore } from "../../store/auth";
import { ref, watchEffect } from "vue";
import TransactionCard from "./TransactionCard.vue";
const authStore = useAuthStore();
let transactions = ref([]);

watchEffect(async () => {
  const res = await authStore.whoamiActor?.get_transactions();
  transactions.value = await res;

  console.log(transactions);
});
</script>
