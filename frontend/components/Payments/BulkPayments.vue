<!-- <template>
  <div v-if="isLoading">
    <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
  </div>
  <div v-else>

    <div v-if="paymentHistory && paymentHistory.length > 0">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Account
            </th>
            <th class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Amount
            </th>
           
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="payment in paymentHistory" :key="payment.receiver">
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.amount }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.receiver }}</td>
          </tr>
        </tbody>
      </table>
      <button @click="showForm = true" class="w-full px-4 py-2 mt-4 bg-blue-500 text-white rounded-lg hover:bg-blue-600">
         More Payments
      </button>
    </div>
    <div v-else>
    <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
   
   <Header title="Bulk Payments"/>
  
   <form @submit.prevent="submitPayments">
     <div
       v-for="(payment, index) in payments"
       :key="index"
       class="payment-field mb-4"
     >
       <div class="grid grid-cols-3 gap-4">
         
         <input
           v-model="payment.account"
           type="text"
           placeholder="Account Number"
           class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
         />
         <input
           v-model="payment.amount"
           type="number"
           placeholder="Amount"
           class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
         />
       </div>
     </div>
     <button
       type="button"
       @click="addPaymentField"
       class="mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
     >
       Add Another Payment
     </button>
     <button
       type="button"
       @click="submitPayments"
       class="mt-4 px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600"
     >
       Submit Payments
     </button>
   </form>
 </div>
</div>

  </div>
  
</template>

<script setup>
import { ref,watchEffect } from 'vue';
import { useAuthStore } from "../../store/auth";
import Header from '../Common/Header.vue';
import router from "../../router";
import Swal from 'sweetalert2';

let isLoading = ref(false);
let paymentHistory = ref(null);
let showForm = ref(false);

const authStore = useAuthStore();

const payments = ref([{ account: "", amount: "" }]);

const addPaymentField = () => {
  payments.value.push({ account: "", amount: "" });
};


watchEffect(async () => {
const payments = await authStore.whoamiActor?.getBulkPayments();
console.log(payments, "payments");
paymentHistory.value = payments;

});


const submitPayments = async () => {
  try {
    isLoading.value = true;
    const response = await authStore.whoamiActor?.bulkPayment(payments.value.map(payment => ({
      receiver: payment.account,
      amount: BigInt(payment.amount),
    })));
    
    if (response.status === 200) {
      Swal.fire({
        title: 'Payments submitted successfully!',
        icon: 'success',
        confirmButtonText: 'OK',
      });
    } else {
      Swal.fire({
        title: 'Error',
        text: `Error: ${response.status_text}`,
        icon: 'error',
        confirmButtonText: 'OK',
      });
      
    }
  } catch (error) {
    console.error("Error submitting payments:", error);
   // alert("An error occurred while submitting payments.");
    Swal.fire({
      title: 'An error occurred while submitting payments.',
      icon: 'error',
      confirmButtonText: 'OK',
    });
  }
  finally {
    isLoading.value = false;
    // Clear the payments array after submission
    payments.value = [{ account: "", amount: "" }];
  };
};
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style> -->

<template>
  <div v-if="isLoading">
    <div class="flex justify-center items-center h-screen">
      <div
        class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
      ></div>
    </div>
  </div>
  <div v-else>
    <div v-if="paymentHistory && paymentHistory.length > 0">
      <table class="min-w-full divide-y divide-gray-200">
        <thead>
          <tr>
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
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="payment in paymentHistory" :key="payment.receiver">
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.receiver }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ payment.amount }}</td>
          </tr>
        </tbody>
      </table>
      <button
        @click="showForm = !showForm"
        class="w-full px-4 py-2 mt-4 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
      >
        {{ showForm ? "Hide" : "Add More Payments" }}
      </button>
    </div>
    <div v-else>
      <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
        <Header title="Bulk Payments" />
        <form @submit.prevent="submitPayments">
          <div
            v-for="(payment, index) in payments"
            :key="index"
            class="payment-field mb-4"
          >
            <div class="grid grid-cols-3 gap-4">
              <input
                v-model="payment.account"
                type="text"
                placeholder="Account Number"
                class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <input
                v-model="payment.amount"
                type="number"
                placeholder="Amount"
                class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>
          <button
            type="button"
            @click="addPaymentField"
            class="mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
          >
            Add Another Payment
          </button>
          <button
            type="submit"
            class="mt-4 px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600"
          >
            Submit Payments
          </button>
        </form>
      </div>
    </div>
    <div v-if="showForm && paymentHistory && paymentHistory.length > 0">
      <div class="w-full h-full mx-auto bg-white p-6 rounded-lg shadow-md">
        <Header title="Bulk Payments" />
        <form @submit.prevent="submitPayments">
          <div
            v-for="(payment, index) in payments"
            :key="index"
            class="payment-field mb-4"
          >
            <div class="grid grid-cols-3 gap-4">
              <input
                v-model="payment.account"
                type="text"
                placeholder="Account Number"
                class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
              <input
                v-model="payment.amount"
                type="number"
                placeholder="Amount"
                class="p-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              />
            </div>
          </div>
          <button
            type="button"
            @click="addPaymentField"
            class="mt-4 px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-600"
          >
            Add Another Payment
          </button>
          <button
            type="submit"
            class="mt-4 px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600"
          >
            Submit Payments
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import Header from "../Common/Header.vue";
import Swal from "sweetalert2";

let isLoading = ref(false);
let paymentHistory = ref(null);
let showForm = ref(false);

const authStore = useAuthStore();

const payments = ref([{ account: "", amount: "" }]);

const addPaymentField = () => {
  payments.value.push({ account: "", amount: "" });
};

watchEffect(async () => {
  isLoading.value = true;
  try {
    const payments = await authStore.whoamiActor?.getBulkPayments();
    paymentHistory.value = payments;
  } catch (error) {
    console.error("Error fetching payment history:", error);
  } finally {
    isLoading.value = false;
  }
});

const submitPayments = async () => {
  try {
    isLoading.value = true;
    const response = await authStore.whoamiActor?.bulkPayment(
      payments.value.map((payment) => ({
        receiver: payment.account,
        amount: BigInt(payment.amount),
      }))
    );

    if (response.status === 200) {
      Swal.fire({
        title: "Payments submitted successfully!",
        icon: "success",
        confirmButtonText: "OK",
      });
      paymentHistory.value = await authStore.whoamiActor?.getBulkPayments();
    } else {
      Swal.fire({
        title: "Error",
        text: `Error: ${response.status_text}`,
        icon: "error",
        confirmButtonText: "OK",
      });
    }
  } catch (error) {
    console.error("Error submitting payments:", error);
    Swal.fire({
      title: "An error occurred while submitting payments.",
      icon: "error",
      confirmButtonText: "OK",
    });
  } finally {
    isLoading.value = false;
    payments.value = [{ account: "", amount: "" }];
    showForm.value = false;
  }
};
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>
