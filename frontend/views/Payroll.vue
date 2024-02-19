<script setup>
import TableComponent from "../components/TableComponent.vue";
import Searchbar from "../components/Searchbar.vue";
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../store/auth";
const authStore = useAuthStore();

let isRunning = ref(false);
let isOpen = ref(true);
let response = ref("");
let payrollItems = ref([]);
import {
  Dialog,
  DialogPanel,
  DialogTitle,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
let address = ref("");
let amount = ref("");

const openModal = () => {
  isOpen.value = true;
};

const closeModal = () => {
  isOpen.value = false;
};

const addPayment = () => {
  // Handle adding payment logic here

  //add item to payrollItems
  payrollItems.value.push({
    id: payrollItems.value.length + 1,
    address: address.value,
    amount: amount.value,
  });
  console.log("Adding payment:", address.value, amount.value);
  closeModal();
};
const runPayroll = async () => {
  try {
    isRunning.value = true;
    console.log("wtf");
    const res = await authStore.whoamiActor?.runpayroll([
      {
        id: 500,
        creator: "Cosmas",
        destination:
          "frmzq-vsyar-77di6-mjado-ej6nq-xlxox-o32rv-p7s76-2nkcs-d3tcu-cae",
        created_at: 1400,
        amount: 1500,
        successful: true,
      },
      {
        id: 2500,
        creator: "Cosmas",
        destination:
          "5lnja-ztbzy-c4kyn-telka-nwtuk-5h2jn-fcesl-tovut-2ytto-5stlw-pae",
        created_at: 1400,
        amount: 1500,
        successful: true,
      },
    ]);
    response = await res;

    console.log(response);
  } catch (e) {
    console.log("Error fetching data");
  } finally {
    isRunning.value = false;
  }
};
</script>
<template>
  <div class="p-5">
    <div class="bg-white dark:bg-transparent">
      <div class="flex flex-row justify-between">
        <Searchbar />
        <div class="flex flex-row space-x-5">
          <div
            @click="openModal"
            class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
          >
            <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
            <p class="text-base font-light text-white">Add Payment</p>
          </div>
          <div
            @click="runPayroll"
            class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
          >
            <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
            <p class="text-base font-light text-white">Run Payroll</p>
          </div>
        </div>
      </div>

      <!-- table section -->
      <!--TableComponent /-->
      <!-- table section -->
      <!-- loop through payroll items -->
    </div>
    <TransitionRoot as="template" :show="isOpen">
      <Dialog
        as="div"
        class="fixed inset-0 z-10 overflow-y-auto"
        @close="closeModal"
      >
        <TransitionChild
          as="template"
          enter="ease-out duration-300"
          enter-from="opacity-0"
          enter-to="opacity-100"
          leave="ease-in duration-200"
          leave-from="opacity-100"
          leave-to="opacity-0"
        >
          <div
            class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0"
          >
            <TransitionChild
              as="template"
              enter="ease-out duration-300"
              enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
              enter-to="opacity-100 translate-y-0 sm:scale-100"
              leave="ease-in duration-200"
              leave-from="opacity-100 translate-y-0 sm:scale-100"
              leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            >
              <DialogPanel
                as="div"
                class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full"
              >
                <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                  <div class="sm:flex sm:items-start">
                    <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
                      <DialogTitle
                        as="h3"
                        class="text-lg leading-6 font-medium text-gray-900"
                        >Add Payment</DialogTitle
                      >
                      <div class="mt-2">
                        <form @submit.prevent="addPayment">
                          <div>
                            <label
                              for="address"
                              class="block text-sm font-medium text-gray-700"
                              >Address:</label
                            >
                            <input
                              type="text"
                              id="address"
                              v-model="address"
                              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                              required
                            />
                          </div>
                          <div class="mt-3">
                            <label
                              for="amount"
                              class="block text-sm font-medium text-gray-700"
                              >Amount:</label
                            >
                            <input
                              type="number"
                              id="amount"
                              v-model="amount"
                              class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                              required
                            />
                          </div>
                          <div class="mt-4">
                            <button
                              type="submit"
                              class="inline-flex justify-center w-full rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:text-sm"
                            >
                              Add
                            </button>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </DialogPanel>
            </TransitionChild>
          </div>
        </TransitionChild>
      </Dialog>
    </TransitionRoot>
  </div>
</template>
