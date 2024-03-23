<script setup>
import { ref, watchEffect } from "vue"
import { useAuthStore } from "./store/auth"
import Header from "./components/MainHeader.vue"
import router from "./router/"

const authStore = useAuthStore()
const darkmode = ref(false)
let unreadNotifications = ref("")
let fundingaddress = ref("")
let tradingaddress = ref("")
let canisteraddress = ref("")
let tradingbalance = ref("")
let fundingbalance = ref("")
let canisterbalance = ref("")
let transferresponse = ref("")
let sendtocanisterresponse = ref("")
let invoice = ref("")
let notifresponse = ref("")
let showNotification = ref(false)
const selectedAccountType = ref("main")

const logout = () => {
  router.push("/auth")
  authStore.logout()
}

const gotoNotifications = () => {
  router.push("/home/notifications")
}

watchEffect(async () => {
  // const res = await authStore.whoamiActor?.getInvoice();
  // invoice.value = await res;
  setInterval(async function() {
    try {
      notifresponse =
        await authStore.whoamiActor?.getUnreadNotificationsLength()
      unreadNotifications.value = await notifresponse
      console.log(notifresponse)
    } catch (e) {
      console.log("Error fetching data")
    } finally {
      if (unreadNotifications.value > 0) {
        showNotification.value = true
        console.log("gets here")
      }
    }
  }, 60000)
})

// watchEffect(async () => {
//   // const res = await authStore.whoamiActor?.getInvoice();
//   // invoice.value = await res;
//   setInterval(
//     async function(){
//       if(unreadNotifications.value > 0){
//           showNotification.value = true;
//          // console.log("gets here");
//         };
//  }, 3000);
// });

const isLoading = ref(false)
const dropdownOpen = ref(false)

watchEffect(async () => {
  const res = await authStore.whoamiActor?.getInvoice()
  invoice.value = await res
})

watchEffect(async () => {
  const res = await authStore.refresh()
  console.log(res)
  tradingbalance.value = await authStore.tradingbalance
  fundingbalance.value = await authStore.fundingbalance
  fundingaddress.value = await authStore.fundingaddress
  tradingaddress.value = await authStore.tradingaddress
  canisteraddress.value = await authStore.canisteraddress
  canisterbalance.value = await authStore.canisterbalance
})
const refreshBalance = async () => {
  try {
    isLoading.value = true
    const res = await authStore.refresh()
    tradingbalance.value = await authStore.tradingbalance
    fundingbalance.value = await authStore.fundingbalance
    fundingaddress.value = await authStore.fundingaddress
    tradingaddress.value = await authStore.tradingaddress
    canisterbalance.value = await authStore.canisterbalance
    console.log(res)
  } catch (e) {
    console.log("Error fetching data")
  } finally {
    isLoading.value = false
  }
}

const getTodaysDate = () => {
  const today = new Date()
  const date =
    today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate()
  return date
}

const getTestTokens = async () => {
  try {
    isLoading.value = true
    const response = authStore.whoamiActor.transferFromCanistertoSubAccount()
    console.log(response)
    transferresponse.value = await response
  } catch (error) {
    console.error("Error Getting tokens:", error)
  } finally {
    isLoading.value = false
  }
}

// const sendToOwner =async () => {
//   try {
//     isLoading.value = true;
//     const response = authStore.whoamiActor.sendToOwner(

//        40000,"5lnja-ztbzy-c4kyn-telka-nwtuk-5h2jn-fcesl-tovut-2ytto-5stlw-pae"

//     );
//     console.log(response);
//     sendtocanisterresponse.value = await response;
//   } catch (error) {
//     console.error("Error Getting tokens:", error);
//   } finally {
//     isLoading.value = false;
//   }

// };

const walletAddress = "0x1234567890123456789012345678901234567890"

const toggleDarkMode = () => {
  darkmode.value = !darkmode.value
  if (darkmode.value) {
    document.documentElement.classList.add("dark")
  } else {
    document.documentElement.classList.remove("dark")
  }
}
</script>

<template class="font-lexend h-screen w-full">
  <div
    class="w-full h-full flex flex-row space-x-[30px] self-stretch bg-white dark:bg-[#16151C]"
  >
    <div
      class="w-[280px] hidden sm:flex flex-col shrink-0 items-stretch rounded-[20px] bg-[#A2A1A80D] p-[30px] h-screen"
    >
      <div class="flex flex-col justify-between h-full">
        <div>
          <div v-if="darkmode">
            <img class="h-[50px]" src="./assets/darklogo.png" />
          </div>
          <div v-else>
            <img class="h-[50px]" src="./assets/logo.png" />
          </div>
          <div class="space-y-[10px] h-full">
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/dashboard"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/dashboard.png"
              />
              <span>Dashboard</span>
            </router-link>

            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/transfer"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/payroll.png"
              />
              <span>Send</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/all-employees"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/payroll.png"
              />
              <span>All Employees</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/contacts"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/payroll.png"
              />
              <span>Contacts</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/transactions"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/payroll.png"
              />
              <span>Transactions</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/payroll"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/payroll.png"
              />
              <span>Bulk Payments</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/notifications"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/candidates.png"
              />
              <span v-if="unreadNotifications.value > 0"
              >Notifications {{ unreadNotifications.value }}</span
              >
              <span v-else>Notifications</span>
            </router-link>
            <router-link
              v-if="authStore.isRegistered === true"
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/home/settings"
            >
              <img
                alt="Vite logo"
                class="shrink-0 h-6 w-6"
                src="./assets/settings.png"
              />
              <span>Profile</span>
            </router-link>
          </div>
        </div>

        <button
          class="border border-gray-300 rounded-[10px] p-1"
          @click="logout"
        >
          Log out
        </button>
        <nav aria-label="Tabs" class="flex rounded-[10px] align-bottom">
          <div
            :class="{
              'bg-[#7152F3]  rounded-[10px] text-white ': !darkmode,
              'bg-transparent text-white': darkmode,
            }"
            class="flex items-center space-x-[10px] cursor-pointer px-3 py-2 text-base font-light"
            @click="toggleDarkMode()"
          >
            <div v-if="darkmode">
              <svg
                fill="none"
                height="24"
                viewBox="0 0 24 24"
                width="24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M12 2V3M12 21V22M19.0711 4.92894L18.364 5.63605M5.63605 18.364L4.92894 19.0711M22 12H21M3 12H2M19.071 19.0711L18.3639 18.364M5.63605 5.63605L4.92894 4.92894M18 12C18 15.3137 15.3137 18 12 18C8.68629 18 6 15.3137 6 12C6 8.68629 8.68629 6 12 6C15.3137 6 18 8.68629 18 12Z"
                  stroke="white"
                  stroke-linecap="round"
                  stroke-width="1.5"
                />
              </svg>
            </div>
            <div v-else>
              <svg
                fill="none"
                height="24"
                viewBox="0 0 24 24"
                width="24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M12 2V3M12 21V22M19.0711 4.92894L18.364 5.63605M5.63605 18.364L4.92894 19.0711M22 12H21M3 12H2M19.071 19.0711L18.3639 18.364M5.63605 5.63605L4.92894 4.92894M18 12C18 15.3137 15.3137 18 12 18C8.68629 18 6 15.3137 6 12C6 8.68629 8.68629 6 12 6C15.3137 6 18 8.68629 18 12Z"
                  stroke="white"
                  stroke-linecap="round"
                  stroke-width="1.5"
                />
              </svg>
            </div>
            <span> Light </span>
          </div>
          <div
            :class="{
              'bg-[#7152F3]  rounded-[10px] ': darkmode,
              'bg-transparent text-[#16151C]': !darkmode,
            }"
            class="flex items-center space-x-[10px] cursor-pointer px-3 py-2 text-base font-light"
            @click="toggleDarkMode()"
          >
            <div v-if="darkmode">
              <svg
                fill="none"
                height="24"
                viewBox="0 0 24 24"
                width="24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M5.67163 14.8687C10.751 14.8687 14.8687 10.751 14.8687 5.67163C14.8687 4.74246 14.7309 3.84548 14.4746 3C18.251 4.14461 21 7.65276 21 11.803C21 16.8824 16.8824 21 11.803 21C7.65276 21 4.14461 18.251 3 14.4746C3.84548 14.7309 4.74246 14.8687 5.67163 14.8687Z"
                  stroke="white"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                />
              </svg>
            </div>
            <div v-else>
              <svg
                fill="none"
                height="24"
                viewBox="0 0 24 24"
                width="24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M5.67163 14.8687C10.751 14.8687 14.8687 10.751 14.8687 5.67163C14.8687 4.74246 14.7309 3.84548 14.4746 3C18.251 4.14461 21 7.65276 21 11.803C21 16.8824 16.8824 21 11.803 21C7.65276 21 4.14461 18.251 3 14.4746C3.84548 14.7309 4.74246 14.8687 5.67163 14.8687Z"
                  stroke="#16151C"
                  stroke-linejoin="round"
                  stroke-width="1.5"
                />
              </svg>
            </div>
            <span> Dark </span>
          </div>
        </nav>
      </div>
    </div>
    <div class="w-full h-full flex flex-col pr-[30px] space-y-2">
      <!-- Header-->
      
<Header/>

      <div class="border border-[#A2A1A833] h-full rounded-[10px]">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
