<script setup>
import { ref, watchEffect } from "vue";
import useClipboard from "vue-clipboard3";
import { useAuthStore } from "./store/auth";
import { useledger } from "./store/useledger";
import { BellAlertIcon } from "@heroicons/vue/20/solid";
import SkeletonLoader from "./components/SkeletonLoader.vue";
import router from "./router/";

const authStore = useAuthStore();
const darkmode = ref(false);
let tradingaddress = ref("");
let fundingaddress = ref("");
let tradingbalance = ref("");
let fundingbalance = ref("");
let transferresponse = ref("");
let invoice = ref("");

const logout = () => {
  router.push("/auth");
  authStore.logout();
};

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getTradingAddress();
  tradingaddress.value = await res;
});

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getFundingAddress();
  fundingaddress.value = await res;
});
watchEffect(async () => {
  const res = await authStore.whoamiActor?.getTradingBalance();
  tradingbalance.value = await res;
});
watchEffect(async () => {
  const res = await authStore.whoamiActor?.getFundingBalance();
  fundingbalance.value = await res;
});

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getInvoice();
  invoice.value = await res;
});

const getTestTokens = async () => {
  const response = authStore.whoamiActor.transferFromCanistertoSubAccount();
  console.log(response);
  transferresponse.value = await response;
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
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/employees"
            >
              <img
                src="./assets/employees.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Employees</span>
            </router-link>
            <router-link
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
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/departments"
            >
              <img
                src="./assets/departments.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Departments</span>
            </router-link-->
            <!--router-link
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
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/payroll"
            >
              <img
                src="./assets/payroll.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Payroll</span>
            </router-link>
            <router-link
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
            </router-link>

            <!--router-link
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
            <SkeletonLoader class="w-16 h-5" />
            </div>
            <div v-else>
              <p
            
            class="text-[#16151C] dark:text-[#ffffff] font-semibold leading-[30px]"
          >
            Hello {{ fundingaddress }} 👋🏻
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
         
          <div v-if="fundingaddress.length === 0"
          class="animate-spin rounded-full h-6 w-6 border-t-2 border-b-2 border-gray-900 dark:border-white"
          >

          </div>
          <div v-else class="rounded-xl border norder-[#F2F7FF] flex flex-col p-2">
            <!--p class="text-sm leading-6 font-semibold text-[#919DB5]">
              FundingAddress : {{ fundingaddress }}
            </p-->
          
              <p class="text-sm leading-6 font-semibold text-[#919DB5]">
                TradingBalance : {{ tradingbalance }} cksats
              </p>
           
           
              <p class="text-sm leading-6 font-semibold text-[#919DB5]">
                FundingBalance : {{ BigInt(Math.round(fundingbalance / 100_000_000)) }} ckbtc
              </p>

              <button  @click="getTestTokens"
              class="bg-blue-700 p-2 text-sm rounded-[10px]"
              >Get Test Tokens</button>

            <div class="flex flex-row justify-between">
             
              <!--div
                class="h-6 w-6 rounded-md bg-[#E0ECFE] flex items-center justify-center cursor-pointer"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="12"
                  height="12"
                  viewBox="0 0 12 12"
                  fill="none"
                >
                  <path
                    d="M7.875 9.75V10.5312C7.875 10.7901 7.66514 11 7.40625 11H2.09375C1.83486 11 1.625 10.7901 1.625 10.5312V3.34375C1.625 3.08486 1.83486 2.875 2.09375 2.875H3.5V8.65625C3.5 9.25936 3.99064 9.75 4.59375 9.75H7.875ZM7.875 3.03125V1H4.59375C4.33486 1 4.125 1.20986 4.125 1.46875V8.65625C4.125 8.91514 4.33486 9.125 4.59375 9.125H9.90625C10.1651 9.125 10.375 8.91514 10.375 8.65625V3.5H8.34375C8.08594 3.5 7.875 3.28906 7.875 3.03125ZM10.2377 2.42521L8.94979 1.13729C8.86188 1.04938 8.74265 1 8.61834 1H8.5V2.875H10.375V2.75666C10.375 2.63234 10.3256 2.51312 10.2377 2.42521Z"
                    fill="#227BF6"
                  />
                </svg>
              </div-->
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

