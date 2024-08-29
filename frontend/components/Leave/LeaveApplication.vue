<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../../store/auth";
import * as yup from "yup";
import Spinner from "../Common/Spinner.vue";
const authStore = useAuthStore();
const filterOpen = ref(false);
const principal = ref("");
const full_name = ref("");
const leave_days = ref("");
const from_date = ref("");
const to_date = ref("");
const reason = ref("");
const handover_to = ref("");
let fundingaddress = ref("");
let tradingaddress = ref("");
let isLoading = ref(false);
let emailExists = ref(false);

watchEffect(async () => {
  isLoading.value = true;
  const user = await authStore.whoamiActor?.getUser();
  if (user.status === 200) {
    console.log("User:", user.data);
    email_address.value = await user.data[0].email_address;
    phone_number.value = await user.data[0].phone_number;
    first_name.value = await user.data[0].first_name;
    last_name.value = await user.data[0].last_name;
  }
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
  }
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
// const addData = async () => {
//   isLoading.value = true;
//   authStore.updateRegistrationData(data);
//   const exists = await authStore.whoamiActor.emailExists(data.email_address);

//   if (exists) {
//     emailExists.value = true;
//     isLoading.value = false;
//     return;
//   }

//   const firstname = authStore.registrationData.first_name;
//   const lastname = authStore.registrationData.last_name;
//   const email = authStore.registrationData.email_address;
//   const phone = authStore.registrationData.phone_number;

//   console.log(firstname, lastname, email, phone);

//   try {
//     const response = authStore.update_user(firstname, lastname, email, phone);
//     // if (response.)
//     //await new Promise((resolve) => setTimeout(resolve, 1000));
//   } catch (error) {
//     console.error("Error submitting data:", error);
//   } finally {
//     isLoading.value = false;
//     refresh();
//   }
// };
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
          class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-4 gap-5 mt-4"
        >
          <div class="lg:col-span-2">
            <label
              for="full-name"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Full Name</label
            >
            <div class="mt-1">
              <input
                v-model="data.full_name"
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="full-name"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="leave-days"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Leave Days
            </label>
            <div class="mt-1">
              <input
                v-model="data.leave_days"
                type="text"
                name="leave-days"
                id="leave-days"
                autocomplete="leave-days"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="from-date"
              class="block text-sm font-medium leading-6 text-gray-600"
              >From</label
            >
            <div class="mt-1">
              <input
                v-model="data.from_date"
                type="text"
                name="from_date"
                id="from_date"
                autocomplete="from_date"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div class="lg:col-span-2">
            <label
              for="to-date"
              class="block text-sm font-medium leading-6 text-gray-600"
              >To</label
            >
            <div class="mt-1">
              <input
                v-model="data.to_date"
                type="text"
                name="to-date"
                id="to-date"
                autocomplete="to-date"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
            </div>
          </div>
          <div class="lg:col-span-4">
            <label
              for="reason"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Reason</label
            >
            <div class="mt-1">
              <textarea
                v-model="data.reason"
                type="text"
                name="reason"
                id="reason"
                autocomplete="reason"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              ></textarea>
            </div>
          </div>

          <div class="lg:col-span-4">
            <label
              for="handover-to"
              class="block text-sm font-medium leading-6 text-gray-600"
              >Handover To</label
            >
            <div class="mt-1">
              <input
                v-model="data.to_date"
                type="text"
                name="handover-to"
                id="handover-to"
                autocomplete="handover-to"
                class="block w-full rounded-md border-0 p-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
              />
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
