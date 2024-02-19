<script setup>
import router from "../router";
import { ref, watchEffect } from "vue";
import OverviewCard from "../components/OverviewCard.vue";
import { useAuthStore } from "../store/auth";
import { Field, Form, ErrorMessage } from "vee-validate";
import * as yup from 'yup';
const authStore = useAuthStore();
let transactions = ref(0);
let contacts = ref(0);
let isLoading = ref(false);
let tradingbalance = ref("");

watchEffect(async () => {
  tradingbalance.value = await authStore.tradingbalance;
});

watchEffect(async () => {
  isLoading.value = true;
  try {
    const transactionLength =
      await authStore.whoamiActor?.getMyTransactionLength();
    const contactsLength = await authStore.whoamiActor?.getMyContactsLength();
    transactions.value = transactionLength;
    contacts.value = contactsLength;
    //await new Promise((resolve) => setTimeout(resolve, 2000));
  } catch (e) {
    console.log("Error fetching data");
  } finally {
    isLoading.value = false;
  }
});
const registrationData = {
  first_name: "",
  last_name: "",
  email: "",
  phone_number: "",
};
const schema = yup.object({
  email: yup.string().required().email(),
  firstname: yup.string().required(),
  lastname: yup.string().required(),
  phone: yup.string().required(),
});
const addData = async () => {
  isLoading.value = true;
  authStore.updateRegistrationData(registrationData);
  const firstname = authStore.registrationData.first_name;
  const lastname = authStore.registrationData.last_name;
  const email = authStore.registrationData.email;
  const phone = authStore.registrationData.phone_number;

  console.log(firstname, lastname, email, phone);

  try {
    const response = authStore.update_user(firstname, lastname, email, phone);
    await new Promise((resolve) => setTimeout(resolve, 2000));
  } catch (error) {
    console.error("Error submitting data:", error);
  } finally {
    isLoading.value = false;
  }
};
</script>
<template>
  <div v-show="isLoading">
    <div class="flex justify-center items-center h-screen">
      <div
        class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
      ></div>
    </div>
  </div>
  <div>
    <div v-if="authStore.isRegistered === false">
      <div class="flex items-center justify-center h-screen">
        <Form class="text-center card" @submit="addData" :validation-schema="schema">
          <p class="text-lg font-semibold mb-3">Welcome to the app!</p>
          <p class="text-sm mb-3">You havent created your profile yet.</p>
          <p class="text-sm mb-3">
            Please add your data and save it to continue using the app.
          </p>
          <label for="firstname" class="label-text text-left">What is your first name</label>
          <Field
            name="firstname"
            as="input"
            type="text"
            v-model="registrationData.first_name"
            placeholder="First Name"
            class="input input-bordered w-full max-w-xs"
            rules="required|firstname"
          />
          <ErrorMessage class="label-text text-left" name="firstname" />
          <label for="lastname" class="label-text text-left">What is your last name</label>
          <Field
            name="lastname"
            as="input"
            type="text"
            v-model="registrationData.last_name"
            placeholder="Last Name"
            class="input input-bordered w-full max-w-xs"
            rules="required|lastname"
          />
          <ErrorMessage class="label-text text-left" name="lastname" />
          <label for="email" class="label-text text-left">What is your email?</label>
          <Field
            name="email"
            as="input"
            type="text"
            v-model="registrationData.email"
            placeholder="Email address"
            class="input input-bordered w-full max-w-xs"
            rules="required|email"
          />
          <ErrorMessage class="label-text text-left" name="email" />
          <label for="phone" class="label-text text-left">What is your phone number</label>
          <Field
            name="phone"
            as="input"
            type="text"
            v-model="registrationData.phone_number"
            placeholder="Phone Number"
            class="input input-bordered w-full max-w-xs"
            rules="required|phone"
          />
          <ErrorMessage class="label-text text-left" name="phone" />

          <div class="card-actions justify-end">
            <button class="btn btn-primary">Save</button>
          </div>
        </Form>
      </div>
    </div>

    <div v-else>
      <div class="p-5 flex flex-col gap-5">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div class="rounded-lg py-2 px-4 shadow-sm bg-[#EDFFFB]">
            <div class="flex flex-col space-y-2">
              <p class="text-base font-semibold text-[#36B293]">Balance</p>

              <div
                class="flex basis-1/2 flex-col border-r border-gray-300 shrink-0"
              >
                <p class="text-xs font-normal">CKBTC</p>
                <p class="font-semibold text-2xl text-[#36B293]">
                  {{ tradingbalance }}
                </p>
              </div>
            </div>
          </div>

          <OverviewCard
            header="Outstanding Amount"
            currency1="CKBTC"
            headercolor="#4C98FF"
            bgcolor="#E0ECFE"
            currency1color="#4C98FF"
            currency2color="#4C98FF"
          />
          <OverviewCard
            header="Upcoming Payments"
            currency1="CKBTC"
            headercolor="#1F2937"
            bgcolor="#FFF"
            currency1color="#4C98FF"
            currency2color="#F6BB22"
          />
          <div class="rounded-lg py-2 px-4 shadow-sm bg-[#FFF]">
            <div class="flex flex-col space-y-2">
              <p class="text-base font-semibold text-[#1F2937]">Transactions</p>

              <div
                class="flex basis-1/2 flex-col border-r border-gray-300 shrink-0"
              >
                <p class="text-xs font-normal">CKBTC</p>
                <p class="font-semibold text-2xl text-[#36B293]">
                  {{ transactions }}
                </p>
              </div>
            </div>
          </div>
          <!--OverviewCard
            header="Transactions"
            currency1="CKBTC"
            headercolor="#1F2937"
            bgcolor="#FFF"
            currency1color="#36B293"
            currency2color="#F6BB22"
          /-->
        </div>

        <div class="flex flex-row">
          <div class="w-full">
            <div class="flex flex-col w-full">
              <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
                <div
                  class="flex flex-col border border-[#A2A1A833] rounded-[10px] divide-y divide-[#A2A1A833]"
                >
                  <div class="px-4 pt-4 pb-[10px]">
                    <div class="flex flex-row">
                      <img
                        src="../assets/totalemp.png"
                        alt=""
                        class="w-6 h-6"
                      />
                      <p
                        class="text-[#16151C] dark:text-white text-sm leading-[22px] font-light"
                      >
                        Transactions
                      </p>
                    </div>
                    <div class="flex flex-row justify-between items-center">
                      <p
                        class="text-[#16151C] dark:text-white text-[30px] leading-10 font-semibold"
                      >
                        {{ transactions }}
                      </p>
                      <div
                        class="flex flex-row space-x-[10px] items-center bg-[#30BE821A] p-[5px] rounded-[5px]"
                      >
                        <img
                          src="../assets/up-arrow.png"
                          alt=""
                          class="w-6 h-6"
                        />
                        <p
                          class="text-[#30BE82] text-[11px] leading-[16px] font-light"
                        >
                          12
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="px-4 py-[10px]">
                    <p class="text-[#A2A1A8] font-light text-xs leading-[18px]">
                      Update: July 16, 2023
                    </p>
                  </div>
                </div>
                <div
                  class="flex flex-col border border-[#A2A1A833] rounded-[10px] divide-y divide-[#A2A1A833]"
                >
                  <div class="px-4 pt-4 pb-[10px]">
                    <div class="flex flex-row">
                      <img
                        src="../assets/totalemp.png"
                        alt=""
                        class="w-6 h-6"
                      />
                      <p
                        class="text-[#16151C] dark:text-white text-sm leading-[22px] font-light"
                      >
                        Contacts
                      </p>
                    </div>
                    <div class="flex flex-row justify-between items-center">
                      <p
                        class="text-[#16151C] dark:text-white text-[30px] leading-10 font-semibold"
                      >
                        {{ contacts }}
                      </p>
                      <div
                        class="flex flex-row space-x-[10px] items-center bg-[#30BE821A] p-[5px] rounded-[5px]"
                      >
                        <img
                          src="../assets/up-arrow.png"
                          alt=""
                          class="w-6 h-6"
                        />
                        <p
                          class="text-[#30BE82] text-[11px] leading-[16px] font-light"
                        >
                          12
                        </p>
                      </div>
                    </div>
                  </div>
                  <div class="px-4 py-[10px]">
                    <p class="text-[#A2A1A8] font-light text-xs leading-[18px]">
                      Update: July 16, 2023
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
