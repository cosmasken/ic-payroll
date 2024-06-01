<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import * as yup from "yup";
import Spinner from "../Common/Spinner.vue";
const authStore = useAuthStore();
const filterOpen = ref(false);
const principal = ref("");
const first_name = ref("");
const last_name = ref("");
const email_address = ref("");
const phone_number = ref("");
let fundingaddress = ref("")
let tradingaddress = ref("")
let isLoading = ref(false);
let emailExists = ref(false);

watchEffect(async () => {
  const identity = await authStore.whoamiActor?.whoami();
  principal.value = identity;
});


watchEffect(async () => {
  fundingaddress.value = await authStore.whoamiActor.getFundingAddress();
  tradingaddress.value = await authStore.whoamiActor.getTradingAddress();
})

watchEffect(async () => {
  isLoading.value = true;
  const user = await authStore.whoamiActor?.getUser();
  if (user.status === 200) {
    console.log("User:", user.data);
    email_address.value = await user.data[0].email_address;
    phone_number.value = await user.data[0].phone_number;
    first_name.value = await user.data[0].first_name;
    last_name.value = await user.data[0].last_name;
  };
  isLoading.value = false;
});

const refresh = async () => {
  isLoading.value = true;
  const user = await authStore.whoamiActor?.getUser();
  if (user.status === 200) {
    console.log("User:", user.data);
    email_address.value = await user.data[0].email_address;
    phone_number.value = await user.data[0].phone_number;
    first_name.value = await user.data[0].first_name;
    last_name.value = await user.data[0].last_name;
  };
  isLoading.value = false;
};
const phoneRegExp =
  /^((\\+[1-9]{1,4}[ \\-]*)|(\\([0-9]{2,3}\\)[ \\-]*)|([0-9]{2,4})[ \\-]*)*?[0-9]{3,4}?[ \\-]*[0-9]{3,4}?$/;

watchEffect(async () => {
  const identity = await authStore.whoamiActor?.whoami();
  principal.value = identity;
});
const organizations = [
  {
    id: 1,
    name: "HarambeeApps",
  },
  {
    id: 2,
    name: "BitPochi",
  },
  {
    id: 3,
    name: "Bounty Safari",
  },
];
const data = {
  first_name: "",
  last_name: "",
  email_address: "",
  phone_number: "",
};

const schema = yup.object({
  email: yup.string().required().email(),
  firstname: yup.string().required(),
  lastname: yup.string().required(),
  phone: yup.string().required(),
  phone: yup.string().matches(phoneRegExp, "Phone number is not valid"),
});
const addData = async () => {
  isLoading.value = true;
  authStore.updateRegistrationData(data);
  const exists = await authStore.whoamiActor.emailExists(
    data.email_address
  );

  if (exists) {
    emailExists.value = true;
    isLoading.value = false;
    return;
  }

  const firstname = authStore.registrationData.first_name;
  const lastname = authStore.registrationData.last_name;
  const email = authStore.registrationData.email_address;
  const phone = authStore.registrationData.phone_number;

  console.log(firstname, lastname, email, phone);

  try {
    const response = authStore.update_user(firstname, lastname, email, phone);
    // if (response.)
    //await new Promise((resolve) => setTimeout(resolve, 1000));
  } catch (error) {
    console.error("Error submitting data:", error);
  } finally {
    isLoading.value = false;
    refresh();
  }
};
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
<Spinner/>
        </div>
        <div v-else>
          <div
      v-if="authStore.isRegistered === false"
        class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-4 gap-5 mt-4"
      >
        <div class="lg:col-span-2">
          <label
            for="first-name"
            class="block text-sm font-medium leading-6 text-gray-600"
            >First Name</label
          >
          <div class="mt-1">
            <input
              v-model="data.first_name"
              type="text"
              name="first-name"
              id="first-name"
              autocomplete="first-name"
              class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
            />
          </div>
        </div>
        <div class="lg:col-span-2">
          <label
            for="last-name"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Last name</label
          >
          <div class="mt-1">
            <input
              v-model="data.last_name"
              type="text"
              name="last-name"
              id="last-name"
              autocomplete="last-name"
              class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
            />
          </div>
        </div>
        <div class="lg:col-span-2">
          <label
            for="phone-number"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Phone</label
          >
          <div class="mt-1">
            <input
              v-model="data.phone_number"
              type="text"
              name="phone-number"
              id="phone-number"
              autocomplete="phone-number"
              class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
            />
          </div>
        </div>
        <div class="lg:col-span-2">
          <label
            for="email"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Email</label
          >
          <div class="mt-1">
            <input
              v-model="data.email_address"
              type="text"
              name="email"
              id="email"
              autocomplete="email"
              class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
            />
          </div>
        </div>
      </div>
      <div
      v-else
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
              class="block w-full rounded-md   text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >{{ first_name }}</div>
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
              class="block w-full rounded-md   text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >{{ last_name }}</div>
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
              class="block w-full rounded-md  text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >{{ phone_number }}</div>
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
              class="block w-full rounded-md  text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >
          {{ email_address }}</div>
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
              class="block w-full rounded-md  text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >
          {{ principal }}</div>
          </div>
        </div>
        <div class="lg:col-span-4">
          <label
            for="fundingaddress"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Funding Address</label
          >
          <div class="mt-1">
            <div
              type="text"
              name="fundingaddress"
              id="fundingaddress"
              autocomplete="fundingaddress"
              class="block w-full rounded-md  text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >
          {{ fundingaddress }}</div>
          </div>
        </div>
        <div class="lg:col-span-4">
          <label
            for="tradingaddress"
            class="block text-sm font-medium leading-6 text-gray-600"
            >Trading Address</label
          >
          <div class="mt-1">
            <div
              type="text"
              name="tradingaddress"
              id="tradingaddress"
              autocomplete="tradingaddress"
              class="block w-full rounded-md  text-gray-900 shadow-xs  sm:text-sm sm:leading-6"
            >
          {{ tradingaddress }}</div>
          </div>
        </div>
      </div>
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
