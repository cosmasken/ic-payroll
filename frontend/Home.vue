<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "./store/auth";
import SkeletonLoader from "./components/SkeletonLoader.vue";
import router from "./router/";
import {formatCkBtc} from "./utils/formatCkBtc"

const authStore = useAuthStore();
const darkmode = ref(false);
let tradingaddress = ref("");
let fundingaddress = ref("");
let canisteraddress = ref("");
let tradingbalance = ref("");
let fundingbalance = ref("");
let canisterbalance = ref("");
let transferresponse = ref("");
let invoice = ref("");
let isConfig = ref(false);

const logout = () => {
  router.push("/auth");
  authStore.logout();
};

// const formatCkBtc(amount) = async () => {

// }

// const formatCkBtc(amount) {
//   if (amount === undefined) return "0";
//   amount = typeof amount === "number" ? BigInt(amount) : amount;
//   if (!amount) return "0";
//   const integerPart = amount / 100000000n;
//   const fractionalPart = amount % 100000000n;
//   const fractionalPartString = fractionalPart.toString().padStart(8, "0");
//   const fractionalPartTrimmed = fractionalPartString.replace(/0+$/, ""); // Removes trailing zeroes
//   return `${integerPart.toLocaleString()}.${fractionalPartTrimmed}`;
// };

const isLoading = ref(false);

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getInvoice();
  invoice.value = await res;
});

//  watchEffect(async () => {
//    const res = await authStore.getTransactions();
// console.log(res);
//  });

watchEffect(async () => {
  const res = await authStore.refresh();
  console.log(res);
  tradingbalance.value = await authStore.tradingbalance;
  fundingbalance.value = await authStore.fundingbalance;
  fundingaddress.value = await authStore.fundingaddress;
  canisteraddress.value = await authStore.canisteraddress;
  canisterbalance.value = await authStore.canisterbalance;
});
const refreshBalance = async () => {

try{
  isLoading.value = true;
  const res = await authStore.refresh();
  tradingbalance.value = await authStore.tradingbalance;
fundingbalance.value = await authStore.fundingbalance;
fundingaddress.value = await authStore.fundingaddress;
canisterbalance.value = await authStore.canisterbalance;
console.log(res);
}catch(e){
  console.log("Error fetching data");
}finally{
  isLoading.value = false;
}

};

const getTestTokens = async () => {
  try{
    isLoading.value = true;
    const response = authStore.whoamiActor.transferFromCanistertoSubAccount();
  console.log(response);
  transferresponse.value = await response;
  } catch (error) {
    console.error("Error Getting tokens:", error);

  } finally {
    isLoading.value = false;
  }
  
};



const walletAddress = "0x1234567890123456789012345678901234567890";

const toggleDarkMode = () => {
  darkmode.value = !darkmode.value;
  if (darkmode.value) {
    document.documentElement.classList.add("dark");
  } else {
    document.documentElement.classList.remove("dark");
  }
};
</script>

<template class="font-lexend h-full w-full">
  <div
    class="w-full p-5 h-full flex flex-row space-x-[30px] self-stretch bg-white dark:bg-[#16151C]"
  >
    <div
      class="w-[280px] hidden sm:flex flex-col shrink-0 items-stretch rounded-[20px] bg-[#A2A1A80D] p-[30px] h-screen"
    >
      <div class="flex flex-col justify-between h-full">
        <div>
          <div v-if="darkmode">
            <img src="./assets/darklogo.png" class="h-[50px]" />
          </div>
          <div v-else>
            <img src="./assets/logo.png" class="h-[50px]" />
          </div>
          <div class="space-y-[10px] h-full">
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/dashboard"
            >
              <img
                src="./assets/dashboard.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Dashboard</span>
            </router-link>
      
            <router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/transfer"
            >
              <img
                src="./assets/payroll.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Send</span>
            </router-link>
            
            <!--router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/attendance"
            >
              <img
                src="./assets/attendance.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Attendance</span>
            </router-link-->
            <router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/payroll"
            >
              <img
                src="./assets/payroll.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Transactions</span>
            </router-link>
            <!--router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/jobs"
            >
              <img
                src="./assets/jobs.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Jobs</span>
            </router-link-->

            <!--router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/candidates"
            >
              <img
                src="./assets/candidates.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Candidates</span>
            </router-link-->
            <router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/candidates"
            >
              <img
                src="./assets/candidates.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Notifications</span>
            </router-link>
            <!--router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/leaves"
            >
              <img
                src="./assets/leaves.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Leaves</span>
            </router-link-->
            <!--router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/holidays"
            >
              <img
                src="./assets/holidays.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Holidays</span>
            </router-link-->
            <router-link
              v-if="authStore.isConfigured === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/settings"
            >
              <img
                src="./assets/settings.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Settings</span>
            </router-link>
          </div>
        </div>

        <button
          @click="logout"
          class="border border-gray-300 rounded-[10px] p-5"
        >
          Log out
        </button>
        <nav class="flex rounded-[10px] align-bottom" aria-label="Tabs">
          <div
            @click="toggleDarkMode()"
            :class="{
              'bg-[#7152F3]  rounded-[10px] text-white ': !darkmode,
              'bg-transparent text-white': darkmode,
            }"
            class="flex items-center space-x-[10px] cursor-pointer px-3 py-2 text-base font-light"
          >
            <div v-if="darkmode">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <path
                  d="M12 2V3M12 21V22M19.0711 4.92894L18.364 5.63605M5.63605 18.364L4.92894 19.0711M22 12H21M3 12H2M19.071 19.0711L18.3639 18.364M5.63605 5.63605L4.92894 4.92894M18 12C18 15.3137 15.3137 18 12 18C8.68629 18 6 15.3137 6 12C6 8.68629 8.68629 6 12 6C15.3137 6 18 8.68629 18 12Z"
                  stroke="white"
                  stroke-width="1.5"
                  stroke-linecap="round"
                />
              </svg>
            </div>
            <div v-else>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <path
                  d="M12 2V3M12 21V22M19.0711 4.92894L18.364 5.63605M5.63605 18.364L4.92894 19.0711M22 12H21M3 12H2M19.071 19.0711L18.3639 18.364M5.63605 5.63605L4.92894 4.92894M18 12C18 15.3137 15.3137 18 12 18C8.68629 18 6 15.3137 6 12C6 8.68629 8.68629 6 12 6C15.3137 6 18 8.68629 18 12Z"
                  stroke="white"
                  stroke-width="1.5"
                  stroke-linecap="round"
                />
              </svg>
            </div>
            <span> Light </span>
          </div>
          <div
            @click="toggleDarkMode()"
            :class="{
              'bg-[#7152F3]  rounded-[10px] ': darkmode,
              'bg-transparent text-[#16151C]': !darkmode,
            }"
            class="flex items-center space-x-[10px] cursor-pointer px-3 py-2 text-base font-light"
          >
            <div v-if="darkmode">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <path
                  d="M5.67163 14.8687C10.751 14.8687 14.8687 10.751 14.8687 5.67163C14.8687 4.74246 14.7309 3.84548 14.4746 3C18.251 4.14461 21 7.65276 21 11.803C21 16.8824 16.8824 21 11.803 21C7.65276 21 4.14461 18.251 3 14.4746C3.84548 14.7309 4.74246 14.8687 5.67163 14.8687Z"
                  stroke="white"
                  stroke-width="1.5"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <div v-else>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
              >
                <path
                  d="M5.67163 14.8687C10.751 14.8687 14.8687 10.751 14.8687 5.67163C14.8687 4.74246 14.7309 3.84548 14.4746 3C18.251 4.14461 21 7.65276 21 11.803C21 16.8824 16.8824 21 11.803 21C7.65276 21 4.14461 18.251 3 14.4746C3.84548 14.7309 4.74246 14.8687 5.67163 14.8687Z"
                  stroke="#16151C"
                  stroke-width="1.5"
                  stroke-linejoin="round"
                />
              </svg>
            </div>
            <span> Dark </span>
          </div>
        </nav>
      </div>
    </div>
    <div class="w-full flex flex-col pt-4 pr-[30px] space-y-[46px]">
      <!-- Header-->
      <div class="w-full sticky flex flex-row justify-between">
        <div class="flex flex-col">
          <div v-if="fundingaddress.length === 0">
            <SkeletonLoader class="w-36 h-5" />
          </div>
          <div v-else>
            <p
              class="text-[#16151C] dark:text-[#ffffff] font-semibold leading-[30px]"
            >
              Hello {{ fundingaddress }} 👋🏻
            </p>
            <p
              class="text-[#16151C] dark:text-[#ffffff] font-semibold leading-[30px]"
            >
              Canister Address is {{ canisteraddress }}
            </p>
          </div>

          <!--p
            class="text-[#16151C] dark:text-[#ffffff] font-semibold leading-[30px]"
          >
            Trading {{ tradingaddress }} 👋🏻
          </p-->

          <!--p class="text-[#A2A1A8] dark:text-[#A2A1A8] font-light">Subtitle</p-->
        </div>
        <div class="flex flex-row justify-evenly items-center space-x-5">
          <div
            v-if="fundingaddress.length === 0"
            class="animate-spin rounded-full h-6 w-6 border-t-2 border-b-2 border-gray-900 dark:border-white"
          ></div>
          <div
            v-else
            class="rounded-xl border norder-[#F2F7FF] flex flex-col p-2"
          >
          <div>
            <div v-if="isLoading">
              <span class="loading loading-spinner loading-xs"></span>
            </div>
            <div v-else> 
            <p
              class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
            >
              TradingBalance : {{ tradingbalance }} ckSats
            </p>
            <p
              class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
            >
              Canister Balance : {{ canisterbalance }} ckSats 
            </p>
            </div>
          </div>
           

            <p
              class="uppercase tracking-widest text-gray-800 dark:text-white font-semibold"
            >
              FundingBalance : {{ BigInt(Math.round(fundingbalance)) }} ckSats
            </p>

            <button
           
              @click="getTestTokens"
              class="bg-blue-700 p-2 text-sm rounded-[10px]"
            >
              Get Test Tokens
            </button>

            <div class="flex flex-row justify-between">
              <div
                @click="refreshBalance"
                class="h-6 w-6 rounded-md flex items-center justify-center cursor-pointer"
              >
                <div v-if="isLoading">
                  <span class="loading loading-spinner loading-xs"></span>
                </div>
                <div v-else>
                  <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-6 h-6"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0 3.181 3.183a8.25 8.25 0 0 0 13.803-3.7M4.031 9.865a8.25 8.25 0 0 1 13.803-3.7l3.181 3.182m0-4.991v4.99"
                  />
                </svg>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="border border-[#A2A1A833] h-full rounded-[10px]">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
