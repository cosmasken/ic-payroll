<template>
  <div class="flex flex-col justify-between h-full">
    <div>
      <div v-if="darkmode">
        <img src="../assets/darklogo.png" class="h-[50px]" />
      </div>
      <div v-else>
        <img src="../assets/logo.png" class="h-[50px]" />
      </div>
      <div class="space-y-[10px] h-full">
        <router-link
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/dashboard"
        >
          <img
            src="../assets/dashboard.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
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
            src="../assets/payroll.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
          />
          <span>Send</span>
        </router-link>
        <router-link
          v-if="authStore.isRegistered === true"
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/contacts"
        >
          <img
            src="../assets/payroll.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
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
            src="../assets/payroll.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
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
            src="../assets/payroll.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
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
            src="../assets/candidates.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
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
            src="../assets/settings.png"
            class="shrink-0 h-6 w-6"
            alt="Vite logo"
          />
          <span>Profile</span>
        </router-link>
      </div>
    </div>

    <button @click="logout" class="border border-gray-300 rounded-[10px] p-5">
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
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import router from "../router/";
const authStore = useAuthStore();
const darkmode = ref(false);
const logout = () => {
  router.push("/auth");
  authStore.logout();
};

const toggleDarkMode = () => {
  darkmode.value = !darkmode.value;
  if (darkmode.value) {
    document.documentElement.classList.add("dark");
  } else {
    document.documentElement.classList.remove("dark");
  }
};
watchEffect(async () => {
  // const res = await authStore.whoamiActor?.getInvoice();
  // invoice.value = await res;
  setInterval(async function () {
    try {
      notifresponse =
        await authStore.whoamiActor?.getUnreadNotificationsLength();
      unreadNotifications.value = await notifresponse;
      console.log(notifresponse);
    } catch (e) {
      console.log("Error fetching data");
    } finally {
      if (unreadNotifications.value > 0) {
        showNotification.value = true;
        console.log("gets here");
      }
    }
  }, 60000);
});
</script>
