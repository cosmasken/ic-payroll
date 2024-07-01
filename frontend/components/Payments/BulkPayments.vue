<template>
  <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold mb-6">Bulk Payments</h2>
    <form @submit.prevent="submitPayments">
      <div v-for="(payment, index) in payments" :key="index" class="payment-field mb-4">
        <div class="grid grid-cols-3 gap-4">
          <input v-model="payment.name" type="text" placeholder="Recipient Name" class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          <input v-model="payment.account" type="text" placeholder="Account Number" class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
          <input v-model="payment.amount" type="number" placeholder="Amount" class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
      </div>
      <button type="button" @click="addPaymentField" class="mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600">Add Another Payment</button>
      <button type="submit" class="mt-4 px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600">Submit Payments</button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      payments: [
        { name: '', account: '', amount: '' }
      ]
    };
  },
  methods: {
    addPaymentField() {
      this.payments.push({ name: '', account: '', amount: '' });
    },
    submitPayments() {
      // Handle form submission logic
      alert('Payments submitted!');
    }
  }
}
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>
