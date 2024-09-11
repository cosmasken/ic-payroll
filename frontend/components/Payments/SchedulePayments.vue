<template>
  <div v-if="isLoading">
    <div class="flex justify-center items-center h-screen">
      <div
        class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
      ></div>
    </div>
  </div>
  <div v-else></div>
  <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold mb-6">Schedule Payments</h2>

    <div v-if="scheduledPayments && scheduledPayments.length > 0">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Memo
            </th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Account
            </th>
            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Amount
            </th>

            <th
              class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Scheduled After
            </th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="payment in scheduledPayments" :key="payment.id">
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.memo }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.receiver }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.amount }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              {{ payment.scheduled_after }}
            </td>
          </tr>
        </tbody>
      </table>
      <button
        @click="showForm = true"
        class="w-full px-4 py-2 mt-4 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
      >
        Add More Payments
      </button>
    </div>

    <div v-else>
      <button
        @click="showForm = true"
        class="w-full px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
      >
        Add New Payment
      </button>
    </div>

    <div v-if="showForm">
      <form @submit.prevent="schedulePayment">
        <div class="mb-4">
          <input
            v-model="payment.memo"
            type="text"
            placeholder="Memo"
            class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div class="mb-4">
          <input
            v-model="payment.account"
            type="text"
            placeholder="Account Number"
            class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div class="mb-4">
          <input
            v-model="payment.amount"
            type="number"
            placeholder="Amount"
            class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div class="mb-4">
          <input
            v-model="payment.date"
            type="date"
            class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div class="mb-4">
          <input
            v-model="payment.time"
            type="time"
            class="w-full p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <button
          type="submit"
          class="w-full px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600"
        >
          Schedule Payment
        </button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";

const authStore = useAuthStore();

let scheduledPayments = ref(null);
let showForm = ref(false);
let isLoading = ref(false);

watchEffect(async () => {
  const payments = await authStore.whoamiActor?.getAutom8Payments();
  scheduledPayments.value = payments;
});

const formatDate = (createdAt) => {
  const date = new Date(createdAt);
  return date.toLocaleDateString(); // Format as per locale
};

const payment = reactive({
  account: "",
  amount: "",
  memo: "",
  date: "",
  time: "",
  delay: 0,
});

const schedulePayment = async () => {
  const currentDateTime = new Date();
  const scheduledDateTime = new Date(`${payment.date}T${payment.time}`);

  if (scheduledDateTime <= currentDateTime) {
    alert("Scheduled time must be in the future!");
    return;
  }

  payment.delay = Math.floor((scheduledDateTime - currentDateTime) / 1000);

  const args = {
    amount: BigInt(parseInt(payment.amount, 10)),
    receiver: payment.account, // Assuming account is a Principal ID
    memo: payment.memo,
    scheduled_after: BigInt(payment.delay),
  };

  try {
    isLoading.value = true;
    const schedule = await authStore.whoamiActor?.create_Autom8Payment(args);
    console.log(schedule);
    showForm.value = false;
    const payments = await authStore.whoamiActor?.getAutom8Payments();
    scheduledPayments.value = payments;
  } catch (e) {
    console.error(e);
  } finally {
    isLoading.value = false;
    // Reset form
    payment.memo = "";
    payment.account = "";
    payment.amount = "";
    payment.date = "";
    payment.time = "";
    payment.delay = 0;
  }
};
</script>
