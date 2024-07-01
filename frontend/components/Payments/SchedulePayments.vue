<template>
  <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold mb-6">Schedule Payments</h2>
    <form @submit.prevent="schedulePayment">
      <div class="mb-4">
        <input v-model="payment.recipient" type="text" placeholder="Recipient Name" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="mb-4">
        <input v-model="payment.account" type="text" placeholder="Account Number" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="mb-4">
        <input v-model="payment.amount" type="number" placeholder="Amount" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="mb-4">
        <input v-model="payment.date" type="date" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <div class="mb-4">
        <input v-model="payment.time" type="time" class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
      </div>
      <button type="submit" class="w-full px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Schedule Payment</button>
    </form>
  </div>
</template>

<script setup>
import { reactive } from 'vue';

const payment = reactive({
  recipient: '',
  account: '',
  amount: '',
  date: '',
  time: ''
});

const schedulePayment = () => {
  // Handle form submission logic
  alert('Payment scheduled!');
};
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>

<style scoped>
/* Add any scoped styles if necessary */
</style>
