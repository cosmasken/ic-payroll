<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import * as yup from "yup";
import Spinner from "../Common/Spinner.vue";
const authStore = useAuthStore();
let principal = ref("");
let firstname = ref("");
let lastname = ref("");
let emailaddress = ref("");
let phonenumber = ref("");
let accounttype = ref("");
let fundingaddress = ref("");
let tradingaddress = ref("");
let fundingbalance = ref("");
let tradingbalance = ref("");
let isLoading = ref(false);
let isReg = ref(false);

const data = {
  first_name: "",
  last_name: "",
  email_address: "",
  phone_number: "",
  account_type: "",
};

watchEffect(async () => {
  const identity = await authStore.whoamiActor?.whoami();
  principal.value = identity;
});

watchEffect(async () => {
  fundingaddress.value = await authStore.whoamiActor.getFundingAddress();
  tradingaddress.value = await authStore.whoamiActor.getTradingAddress();
});

watchEffect(async () => {
  fundingbalance.value = await authStore.whoamiActor.getFundingBalance();
  tradingbalance.value = await authStore.whoamiActor.getTradingBalance();
});

watchEffect(async () => {
  isLoading.value = true;
  const isReg = await authStore.whoamiActor?.isReg();
  console.log("isReg", isReg);

  if (isReg === true) {
    const user = await authStore.whoamiActor?.getUser();
    if (user.status === 200) {
      console.log("User:", user.data);
      emailaddress.value = await user.data[0].email_address;
      phonenumber.value = await user.data[0].phone_number;
      firstname.value = await user.data[0].first_name;
      lastname.value = await user.data[0].last_name;
      accounttype.value = await user.data[0].account_type;
    }
  }

  isLoading.value = false;
});

const refresh = async () => {
  isLoading.value = true;
  const user = await authStore.whoamiActor?.getUser();
  if (user.status === 200) {
    console.log("User:", user.data);
    emailaddress.value = await user.data[0].email_address;
    phonenumber.value = await user.data[0].phone_number;
    firstname.value = await user.data[0].first_name;
    lastname.value = await user.data[0].last_name;
    accounttype.value = await user.data[0].account_type;
  }
  isLoading.value = false;
};
const phoneRegExp =
  /^((\\+[1-9]{1,4}[ \\-]*)|(\\([0-9]{2,3}\\)[ \\-]*)|([0-9]{2,4})[ \\-]*)*?[0-9]{3,4}?[ \\-]*[0-9]{3,4}?$/;

watchEffect(async () => {
  const identity = await authStore.whoamiActor?.whoami();
  principal.value = identity;
});
</script>
<template>
  <main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div class="mb-6">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Personal details
      </h2>

      <div v-if="isLoading == true">
        <Spinner />
      </div>
      <div v-else>
        <div
          class="w-full h-full mx-auto bg-[#fff] p-6 rounded-lg shadow-md mt-4"
        >
          <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="col-span-1">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >First Name</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ firstname }}
              </div>
            </div>
            <div class="col-span-1">
              <label
                for="last-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Last Name</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ lastname }}
              </div>
            </div>
            <div class="col-span-1">
              <label
                for="phone-number"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Phone</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ phonenumber }}
              </div>
            </div>
            <div class="col-span-1">
              <label
                for="email"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Email</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ emailaddress }}
              </div>
            </div>
            <div class="col-span-2">
              <label
                for="principal"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Principal</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ principal }}
              </div>
            </div>
            <div class="col-span-2">
              <label
                for="funding-balance"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Funding Balance</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ fundingbalance }}
              </div>
            </div>
            <div class="col-span-2">
              <label
                for="trading-balance"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Trading Balance</label
              >
              <div
                class="mt-1 p-2 bg-gray-100 rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ tradingbalance }}
              </div>
            </div>
          </div>
        </div>

        <!--div
          class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-4 gap-5 mt-4"
        >
          <div class="lg:col-span-2">
            <label
              for="first-name"
              class="block text-sm font-medium leading-6 text-gray-600"
              >First Name</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="first-name"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ firstname }}
              </div>
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="first-name"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Last Name</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="first-name"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ lastname }}
              </div>
            </div>
          </div>

          <div class="lg:col-span-2">
            <label
              for="phone-number"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Phone</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="phone-number"
                id="phone-number"
                autocomplete="phone-number"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ phonenumber }}
              </div>
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Email</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="email"
                id="email"
                autocomplete="email"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ emailaddress }}
              </div>
            </div>
          </div>
          <div class="lg:col-span-4">
            <label
              for="principal"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Principal</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="principal"
                id="principal"
                autocomplete="principal"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ principal }}
              </div>
            </div>
          </div>
          <div class="lg:col-span-4">
            <label
              for="principal"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Funding Balance</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="principal"
                id="principal"
                autocomplete="principal"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ fundingbalance }}
              </div>
            </div>
          </div>
          <div class="lg:col-span-4">
            <label
              for="principal"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Trading Balance</label
            >
            <div class="mt-1">
              <div
                type="text"
                name="principal"
                id="principal"
                autocomplete="principal"
                class="block w-full rounded-md text-gray-900 shadow-xs sm:text-sm sm:leading-6"
              >
                {{ tradingbalance }}
              </div>
            </div>
          </div>
       
        </div-->
        <div v-show="authStore.isRegistered === false" class="flex justify-end">
          <button
            @click="addData"
            type="button"
            class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
          >
            Save
          </button>
        </div>
        <div v-show="authStore.isRegistered === true" class="flex justify-end">
          <button
            type="button"
            class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
          >
            Edit
          </button>
        </div>
      </div>
    </div>
  </main>
</template>
