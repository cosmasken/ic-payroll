<template>
<div>
    <div v-show="isLoading === false">
  <form>
    <div class="space-y-12 p-5">
      <div class="border-b border-gray-900/10 pb-12">
        <h2
          class="text-base font-semibold leading-7 text-gray-900 dark:text-white"
        >
          Personal Information
        </h2>
        <p class="mt-1 text-sm leading-6 text-gray-600 dark:text-white">
          Use a permanent address where user can receive mail.
        </p>

        <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-3">
            <label
              for="first-name"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >First name</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.first_name"
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="first-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label
              for="last-name"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Last name</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.last_name"
                type="text"
                name="last-name"
                id="last-name"
                autocomplete="last-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <!--div class="sm:col-span-3">
            <label
              for="designation"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Designation</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.designation"
                type="text"
                name="designation"
                id="designation"
                autocomplete="designation"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div-->

          <div class="sm:col-span-4">
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Email address</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.email"
                id="email"
                name="email"
                type="email"
                autocomplete="email"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <!--div class="sm:col-span-3">
            <label
              for="country"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Country</label
            >
            <div class="mt-2">
              <select
                v-model="registrationData.country"
                id="country"
                name="country"
                autocomplete="country-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option>United States</option>
                <option>Kenya</option>
                <option>Uganda</option>
                <option>Nigeria</option>
              </select>
            </div>
          </div-->

          <div class="col-span-full">
            <label
              for="wallet-address"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Wallet address</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.wallet_address"
                type="text"
                name="wallet-address"
                id="wallet-address"
                autocomplete="wallet-address"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label
              for="phone-number"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Phone</label
            >
            <div class="mt-2">
              <input
                v-model="registrationData.phone_number"
                type="text"
                name="phone-number"
                id="phone-number"
                autocomplete="phone-number"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-6 flex items-center justify-end gap-x-6 p-5">
      <button
        type="button"
        class="text-sm font-semibold leading-6 text-gray-900 dark:text-white"
      >
        Cancel
      </button>
      <button
        type="button"
        
        @click="addData()"
        class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
      >
        Submit
      </button>
      
    </div>
  </form>
</div>
<div v-show="isLoading === true">
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref , watchEffect } from "vue";
import { useAuthStore } from "../store/auth";
const isLoading = ref(false);
const authStore = useAuthStore();


//get currEnt time to int
const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};



const registrationData = {
  first_name: "",
  last_name: "",
  created_at: getTime(),
  email: "",
  phone_number: "",
  wallet_address: "",
};

const addData = () => {
 
  authStore.updateRegistrationData(registrationData);
  const firstname = authStore.registrationData.first_name;
  const lastname = authStore.registrationData.last_name;
  const createdat = authStore.registrationData.created_at;
  const email = authStore.registrationData.email;
  const phone = authStore.registrationData.phone_number;
  const address = authStore.registrationData.wallet_address;

  console.log(firstname, lastname, createdat, email, phone, address);

  try {
    isLoading.value == true;
    const response = authStore.registration(firstname, lastname, email, phone, address);
  } catch (error) {
    console.error('Error submitting data:', error);
  } finally {
    isLoading.value = false;
  }
  
  // const response = authStore.registration(firstname, lastname, email, phone, address);
  // console.log(response);
  // isLoading.value == false;
};

// save data
</script>
