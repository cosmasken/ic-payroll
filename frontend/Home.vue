<script setup>
import { ref } from "vue"
import { useAuthStore } from "./store/auth"
const authStore = useAuthStore()
const darkmode = ref(false)

const toggleDarkMode = () => {
  darkmode.value = !darkmode.value
  if (darkmode.value) {
    document.documentElement.classList.add("dark")
  } else {
    document.documentElement.classList.remove("dark")
  }
}
</script>

<template class="font-lexend h-full w-full">
  <div
    class="w-full p-5 h-full flex flex-row space-x-[30px] self-stretch bg-white dark:bg-[#16151C]"
  >
    <div
      class="w-[280px] hidden sm:flex flex-col shrink-0 items-stretch rounded-[20px] bg-[#A2A1A80D] p-[30px] h-[1048px]"
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
              to="/dashboard"
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
              to="/employees"
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
              to="/departments"
            >
              <img
                src="./assets/departments.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Departments</span>
            </router-link>
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/attendance"
            >
              <img
                src="./assets/attendance.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Attendance</span>
            </router-link>
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/payroll"
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
              to="/jobs"
            >
              <img
                src="./assets/jobs.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Jobs</span>
            </router-link>

            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/candidates"
            >
              <img
                src="./assets/candidates.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Candidates</span>
            </router-link>
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/leaves"
            >
              <img
                src="./assets/leaves.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Leaves</span>
            </router-link>
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/holidays"
            >
              <img
                src="./assets/holidays.png"
                class="shrink-0 h-6 w-6"
                alt="Vite logo"
              />
              <span>Holidays</span>
            </router-link>
            <router-link
              active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D] rounded-r-[10px] text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
              class="group flex flex-row bg-[#7152F30D cursor-pointer rounded-r-[10px] text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
              to="/settings"
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

        <button @click="authStore.logout"
        class="border border-gray-300 rounded-[10px] p-5">
     
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
          <p
            class="text-[#16151C] dark:text-[#ffffff] font-semibold leading-[30px]"
          >
            Hello Cosmas 👋🏻
          </p>
          <p class="text-[#A2A1A8] dark:text-[#A2A1A8] font-light">Subtitle</p>
        </div>
        <div class="flex flex-row justify-evenly items-center space-x-5">
          <div>
            <div class="relative shadow-sm">
              <!--div class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3">
      <div v-if="!darkmode">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
<path fill-rule="evenodd" clip-rule="evenodd" d="M2.75 11.5C2.75 16.3325 6.66751 20.25 11.5 20.25C16.3325 20.25 20.25 16.3325 20.25 11.5C20.25 6.66751 16.3325 2.75 11.5 2.75C6.66751 2.75 2.75 6.66751 2.75 11.5ZM11.5 21.75C5.83908 21.75 1.25 17.1609 1.25 11.5C1.25 5.83908 5.83908 1.25 11.5 1.25C17.1609 1.25 21.75 5.83908 21.75 11.5C21.75 14.0605 20.8111 16.4017 19.2589 18.1982L22.5303 21.4697C22.8232 21.7626 22.8232 22.2374 22.5303 22.5303C22.2374 22.8232 21.7626 22.8232 21.4697 22.5303L18.1982 19.2589C16.4017 20.8111 14.0605 21.75 11.5 21.75Z" fill="#16151C"/>
</svg>
      </div>
      <div v-else>
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
  <path fill-rule="evenodd" clip-rule="evenodd" d="M2.75 11.5C2.75 16.3325 6.66751 20.25 11.5 20.25C16.3325 20.25 20.25 16.3325 20.25 11.5C20.25 6.66751 16.3325 2.75 11.5 2.75C6.66751 2.75 2.75 6.66751 2.75 11.5ZM11.5 21.75C5.83908 21.75 1.25 17.1609 1.25 11.5C1.25 5.83908 5.83908 1.25 11.5 1.25C17.1609 1.25 21.75 5.83908 21.75 11.5C21.75 14.0605 20.8111 16.4017 19.2589 18.1982L22.5303 21.4697C22.8232 21.7626 22.8232 22.2374 22.5303 22.5303C22.2374 22.8232 21.7626 22.8232 21.4697 22.5303L18.1982 19.2589C16.4017 20.8111 14.0605 21.75 11.5 21.75Z" fill="white"/>
</svg>
        </div>
    
    </div-->
              <input
                type="text"
                name="text"
                id="text"
                class="block w-full bg-white dark:bg-[#16151C] border border-[#A2A1A833] rounded-[10px] 0 py-[13px] px-4 text-gray-900 ring-1 ring-inset ring-[#16151C] dark:placeholder:text-[#A2A1A833] placeholder:text-[#16151C33] focus:ring-2 focus:ring-inset focus:ring-[#16151C] sm:text-sm sm:leading-6"
                placeholder="Search"
              />
            </div>
          </div>

          <div>
            <div v-if="darkmode">
              <svg
                width="50"
                height="50"
                viewBox="0 0 50 50"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <rect
                  width="50"
                  height="50"
                  rx="10"
                  fill="#A2A1A8"
                  fill-opacity="0.1"
                />
                <path
                  d="M18.6796 21.794C19.0538 18.4909 21.7709 16 25 16C28.2291 16 30.9462 18.4909 31.3204 21.794L31.6652 24.8385C31.7509 25.595 32.0575 26.3069 32.5445 26.88C33.5779 28.0964 32.7392 30 31.1699 30H18.8301C17.2608 30 16.4221 28.0964 17.4555 26.88C17.9425 26.3069 18.2491 25.595 18.3348 24.8385L18.6796 21.794Z"
                  stroke="#16151C"
                  stroke-width="1.5"
                  stroke-linejoin="round"
                />
                <path
                  d="M28 32C27.5633 33.1652 26.385 34 25 34C23.615 34 22.4367 33.1652 22 32"
                  stroke="#16151C"
                  stroke-width="1.5"
                  stroke-linecap="round"
                />
              </svg>
            </div>
            <div v-else>
              <svg
                width="50"
                height="50"
                viewBox="0 0 50 50"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <rect
                  width="50"
                  height="50"
                  rx="10"
                  fill="#A2A1A8"
                  fill-opacity="0.1"
                />
                <path
                  d="M18.6796 21.794C19.0538 18.4909 21.7709 16 25 16C28.2291 16 30.9462 18.4909 31.3204 21.794L31.6652 24.8385C31.7509 25.595 32.0575 26.3069 32.5445 26.88C33.5779 28.0964 32.7392 30 31.1699 30H18.8301C17.2608 30 16.4221 28.0964 17.4555 26.88C17.9425 26.3069 18.2491 25.595 18.3348 24.8385L18.6796 21.794Z"
                  stroke="#16151C"
                  stroke-width="1.5"
                  stroke-linejoin="round"
                />
                <path
                  d="M28 32C27.5633 33.1652 26.385 34 25 34C23.615 34 22.4367 33.1652 22 32"
                  stroke="#16151C"
                  stroke-width="1.5"
                  stroke-linecap="round"
                />
              </svg>
            </div>
          </div>

          <div
            class="flex flex-row p-[5px] items-center border rounded-lg border-[#A2A1A833]"
          >
            <div class="h-[40px] w-[40px]">
              <img
                src="./assets/dp.png"
                class="h-[40px] w-[40px]"
                alt="Vite logo"
              />
            </div>
            <div class="flex flex-col space-y-[2px]">
              <p class="font-semibold text-base text-[#16151C] dark:text-white">
                Robert Allen
              </p>
              <p class="font-light text-xs text-[#A2A1A8]">Hr Manager</p>
            </div>
            <div class="pl-[10px]">
              <div v-if="darkmode">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="20"
                  height="20"
                  viewBox="0 0 20 20"
                  fill="none"
                >
                  <path
                    d="M5.8335 8.33325L10.0002 11.6666L14.1668 8.33325"
                    stroke="white"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
              </div>
              <div v-else>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="20"
                  height="20"
                  viewBox="0 0 20 20"
                  fill="none"
                >
                  <path
                    d="M5.83333 8.3335L10 11.6668L14.1667 8.3335"
                    stroke="#16151C"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                  />
                </svg>
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
