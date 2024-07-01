<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "./store/auth";
import router from "./router/";
import Alpine from "alpinejs";
const authStore = useAuthStore();
const open = ref(false);
const openCard = ref(false);
const profileOpen = ref(false);
const isLoading = ref(false);
const modal = ref(false);
const organogramOpen = ref(false);
const employeeOpen = ref(false);
const payrollOpen = ref(false);
const leavesOpen = ref(false);
const assetsOpen = ref(false);

const logout = () => {
  // router.push("/auth")
  authStore.logout();
};

Alpine.start();

const selectedLink = ref(null);

const dashboard = [
  { to: "/home/dashboard", text: "Dashboard" },
  // Add more links here
];

const organogram = [
  { to: "/home/designations", text: "Designation" },
  { to: "/home/organizations", text: "Organizations" },
  { to: "/home/departments", text: "Departments" },
  // Add more links here
];
const employees = [
  { to: "/home/all-employees", text: "All Employees" },
  // { to: "/home/consultants", text: "Consultants" },
  { to: "/home/add-employee", text: "Add Employee" },
  // Add more links here
];
const payroll = [
  { to: "/home/all-salary", text: "All Salaries" },
  { to: "/home/deductions", text: "Deductions" },
  { to: "/home/payslips", text: "Payslips" },
  { to: "/home/one-time-payments", text: "One Time Payments" },
  { to: "/home/bulk-payments", text: "Bulk Payments" },
  { to: "/home/schedule-payments", text: "Schedule Payments" },
  { to: "/home/transactions", text: "Transactions" },
  // Add more links here
];

const leaves = [
  { to: "/home/all-leaves", text: "All Leaves" },
  { to: "/home/leave-settings", text: "Leave Settings" },
  { to: "/home/leave-application", text: "Leave Application" },
  // Add more links here
];
const assets = [
  { to: "/home/assign-assets", text: "Assigned Assets" },
  { to: "/home/assigned-assets", text: "Assign Assets" },
  // Add more links here
];

const getTestTokens = async () => {
  try {
    isLoading.value = true;
    const response = authStore.whoamiActor.transferFromCanistertoSubAccount();
    console.log(response);
    // transferresponse.value = await response
  } catch (error) {
    console.error("Error Getting tokens:", error);
  } finally {
    isLoading.value = false;
  }
};
</script>

<template class="font-lexend">
  <main class="h-screen bg-gray-50">
    <div class="flex flex-col min-h-full h-full">
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <div
        v-show="open"
        enter-class="transition ease-out duration-300"
        enter-start-class="opacity-0"
        enter-end-class="opacity-100"
        leave-class="transition ease-in duration-300"
        leave-start-class="opacity-100"
        leave-end-class="opacity-0"
        class="relative z-40 md:hidden"
        role="dialog"
        aria-modal="true"
      >
        <!-- Off-canvas menu backdrop, show/hide based on off-canvas menu state. -->
        <div
          enter-class="transition ease-out duration-300"
          enter-start-class="opacity-0"
          enter-end-class="opacity-100"
          leave-class="transition ease-in duration-300"
          leave-start-class="opacity-100"
          leave-end-class="opacity-0"
          class="fixed inset-0 bg-gray-600 bg-opacity-75"
        ></div>

        <div class="fixed inset-0 z-40 flex">
          <!-- Off-canvas menu, show/hide based on off-canvas menu state. -->
          <div
            enter-class="transition ease-out duration-300"
            enter-start-class="opacity-0 -translate-x-full"
            enter-end-class="opacity-100 -translate-x-0"
            leave-class="transition ease-in duration-300"
            leave-start-class="opacity-100 -translate-x-0"
            leave-end-class="opacity-0 -translate-x-full"
            class="relative flex w-full max-w-xs flex-1 flex-col bg-[#fff]"
          >
            <!-- Close button, show/hide based on off-canvas menu state. -->
            <div
              @click="open = false"
              enter-class="transition ease-out duration-300"
              enter-start-class="opacity-0"
              enter-end-class="opacity-100"
              leave-class="transition ease-in duration-300"
              leave-start-class="opacity-100"
              leave-end-class="opacity-0"
              class="absolute top-0 right-0 -mr-12 pt-2"
            >
              <button
                @click="open = false"
                type="button"
                class="ml-1 flex h-10 w-10 items-center justify-center rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
              >
                <span class="sr-only">Close sidebar</span>
                
                <svg
                  class="h-6 w-6 text-white"
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="2"
                  stroke="currentColor"
                  aria-hidden="true"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M6 18L18 6M6 6l12 12"
                  />
                </svg>
              </button>
            </div>

            <div class="h-0 flex-1 overflow-y-auto pt-5 pb-4 bg-[#fff]">
              <div class="flex flex-shrink-0 items-center px-4">
                <img
                  class="h-8 w-auto"
                  src="./assets/dfinity.svg"
                  alt="ic-payroll"
                />
              </div>
              <nav class="mt-6 space-y-2">
                <router-link
                  to="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  
                  <span class="flex items-center space-x-4">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                      viewBox="0 0 20 22"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M19 4C19 5.65685 14.9706 7 10 7C5.02944 7 1 5.65685 1 4M19 4C19 2.34315 14.9706 1 10 1C5.02944 1 1 2.34315 1 4M19 4V18C19 19.66 15 21 10 21C5 21 1 19.66 1 18V4M19 11C19 12.66 15 14 10 14C5 14 1 12.66 1 11"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                    <span>Dashboard</span>
                  </span>
                </router-link>
                <div class="space-y-1">
                  <a
                    @click="organogramOpen = !organogramOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Organogram</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="organogramOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      to="/home/organizations"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Organizations</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/departments"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Departments</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/designations"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Designations</span>
                      </span>
                    </router-link>
                  </div>
                </div>
                <div class="space-y-1">
                  <a
                    @click="employeeOpen = !employeeOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Employees</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="employeeOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      to="/home/all-employees"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>All Employees</span>
                      </span>
                    </router-link>

                    <!--router-link
                      to="/home/consultants"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                   
                      <span class="flex items-center">
                        <span>Consultants</span>
                      </span>
                    </router-link-->

                    <router-link
                      to="/home/add-employee"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Add Employee</span>
                      </span>
                    </router-link>
                  </div>
                </div>
                <div class="space-y-1">
                  <a
                    @click="payrollOpen = !payrollOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Payroll & Salaries</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="payrollOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      to="/home/one-time-payments"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>One Time Payments</span>
                      </span>
                    </router-link>
                    <router-link
                      to="/home/bulk-payments"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Bulk Payments</span>
                      </span>
                    </router-link>
                    <router-link
                      to="/home/schedule-payments"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Schedule Payments</span>
                      </span>
                    </router-link>
                    <router-link
                      to="/home/transactions"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Transactions</span>
                      </span>
                    </router-link>
                    <router-link
                      to="/home/all-salary"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>All Salaries</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/deductions"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Deductions</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/payslips"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      
                      <span class="flex items-center">
                        <span>Payslips</span>
                      </span>
                    </router-link>
                  </div>
                </div>
                <!--div class="space-y-1">
                  <a
                    @click="leavesOpen = !leavesOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Leaves</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="leavesOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      to="/home/all-leaves"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center">
                        <span>All Leaves</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/leave-application"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center">
                        <span>Leave Application</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/leave-settings"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center">
                        <span>Leave Settings</span>
                      </span>
                    </router-link>
                  </div>
                </div-->
                <!--div class="space-y-1">
                  <a
                    @click="assetsOpen = !assetsOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Assets</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="assetsOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      to="/home/assigned-assets"
                      class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center">
                        <span>Assigned Assets</span>
                      </span>
                    </router-link>

                    <router-link
                      to="/home/assign-assets"
                      class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center">
                        <span>Assign Assets</span>
                      </span>
                    </router-link>
                  </div>
                </div-->
              </nav>
              <nav class="mt-4 flex-1 space-y-2 pt-2">
                <a
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  
                  <span class="flex items-center space-x-3">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                      viewBox="0 0 22 22"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M8.09 8C8.3251 7.33167 8.78915 6.76811 9.39995 6.40913C10.0108 6.05016 10.7289 5.91894 11.4272 6.03871C12.1255 6.15849 12.7588 6.52152 13.2151 7.06353C13.6713 7.60553 13.9211 8.29152 13.92 9C13.92 11 10.92 12 10.92 12M11 16H11.01M21 11C21 16.5228 16.5228 21 11 21C5.47715 21 1 16.5228 1 11C1 5.47715 5.47715 1 11 1C16.5228 1 21 5.47715 21 11Z"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                    <span>Support</span>
                  </span>
                </a>
              </nav>
            </div>
          </div>

          <div class="w-14 flex-shrink-0">
            <!-- Force sidebar to shrink to fit close icon -->
          </div>
        </div>
      </div>
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->

      <!-- Static sidebar for desktop -->
      <div
        class="hidden md:fixed md:inset-y-0 md:flex md:w-64 md:flex-col z-20"
      >
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div
          class="flex min-h-0 flex-1 flex-col border-r border-gray-200 bg-[#fff]"
        >
          <div class="flex flex-1 flex-col overflow-y-auto pt-6 pb-4">
            <div class="flex flex-shrink-0 items-center px-6 lg:px-7">
              <img
                class="h-10 w-auto"
                src="./assets/dfinity.svg "
                alt="ic-payroll"
              />
            </div>
            <div
              class="flex flex-1 flex-col justify-start divide-y divide-gray-200 bg-[#fff] px-3 scrollbar"
            >
              <nav class="mt-6 space-y-2">
                <router-link
                  v-for="(link, index) in dashboard"
                  :key="index"
                  :to="link.to"
                  :class="{ selected: selectedLink === link.to }"
                  @click="selectedLink = link.to"
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                >
                  <span class="flex items-center space-x-4">
                    
                    <span>{{ link.text }}</span>
                  </span>
                </router-link>

                <div class="space-y-1">
                  <a
                    @click="organogramOpen = !organogramOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Organogram</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="organogramOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      v-for="(link, index) in organogram"
                      :key="index"
                      :to="link.to"
                      :class="{ selected: selectedLink === link.to }"
                      @click="selectedLink = link.to"
                      class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                      active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center space-x-4">
                        
                        <span>{{ link.text }}</span>
                      </span>
                    </router-link>
                  </div>
                </div>

                <div class="space-y-1">
                  <a
                    @click="employeeOpen = !employeeOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Employees</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="employeeOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      v-for="(link, index) in employees"
                      :key="index"
                      :to="link.to"
                      :class="{ selected: selectedLink === link.to }"
                      @click="selectedLink = link.to"
                      class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                      active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center space-x-4">
                        
                        <span>{{ link.text }}</span>
                      </span>
                    </router-link>
                  </div>
                </div>

                <div class="space-y-1">
                  <a
                    @click="payrollOpen = !payrollOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Payroll & Salaries</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="payrollOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      v-for="(link, index) in payroll"
                      :key="index"
                      :to="link.to"
                      :class="{ selected: selectedLink === link.to }"
                      @click="selectedLink = link.to"
                      class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                      active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center space-x-4">
                        
                        <span>{{ link.text }}</span>
                      </span>
                    </router-link>
                  </div>
                </div>

                <!--div class="space-y-1">
                  <a
                    @click="leavesOpen = !leavesOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Leaves</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="leavesOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      v-for="(link, index) in leaves"
                      :key="index"
                      :to="link.to"
                      :class="{ selected: selectedLink === link.to }"
                      @click="selectedLink = link.to"
                      class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                      active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center space-x-4">
                        
                        <span>{{ link.text }}</span>
                      </span>
                    </router-link>
                  </div>
                </div-->

                <!--div class="space-y-1">
                  <a
                    @click="assetsOpen = !assetsOpen"
                    href="javascript:void(0) "
                    class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                  >
                    
                    <span class="flex items-center space-x-3">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                        viewBox="0 0 22 22"
                        fill="none"
                        stroke="currentColor"
                      >
                        <path
                          d="M1 11L10.6422 15.8211C10.7734 15.8867 10.839 15.9195 10.9078 15.9324C10.9687 15.9438 11.0313 15.9438 11.0922 15.9324C11.161 15.9195 11.2266 15.8867 11.3578 15.8211L21 11M1 16L10.6422 20.8211C10.7734 20.8867 10.839 20.9195 10.9078 20.9324C10.9687 20.9438 11.0313 20.9438 11.0922 20.9324C11.161 20.9195 11.2266 20.8867 11.3578 20.8211L21 16M1 6L10.6422 1.17889C10.7734 1.1133 10.839 1.0805 10.9078 1.0676C10.9687 1.05616 11.0313 1.05616 11.0922 1.0676C11.161 1.0805 11.2266 1.1133 11.3578 1.17889L21 6L11.3578 10.8211C11.2266 10.8867 11.161 10.9195 11.0922 10.9324C11.0313 10.9438 10.9687 10.9438 10.9078 10.9324C10.839 10.9195 10.7734 10.8867 10.6422 10.8211L1 6Z"
                          stroke-width="2"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                        />
                      </svg>
                      <span>Assets</span>
                    </span>
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="12"
                      height="8"
                      viewBox="0 0 12 8"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M1 1.5L6 6.5L11 1.5"
                        stroke-width="1.66667"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </a>

                  <div
                    x-cloak
                    v-show="assetsOpen"
                    enter.duration.300ms
                    leave.duration.300ms
                    class="pl-[34px] pr-7 space-y-1"
                  >
                    <router-link
                      v-for="(link, index) in assets"
                      :key="index"
                      :to="link.to"
                      :class="{ selected: selectedLink === link.to }"
                      @click="selectedLink = link.to"
                      class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                      active-class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                    >
                      <span class="flex items-center space-x-4">
                        
                        <span>{{ link.text }}</span>
                      </span>
                    </router-link>
                  </div>
                </div-->
              </nav>
              <nav class="mt-4 flex-1 space-y-2 pt-2">
                <a
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  
                  <span class="flex items-center space-x-3">
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="text-gray-500 group-hover:text-gray-900 h-4 w-4 shrink-0"
                      viewBox="0 0 22 22"
                      fill="none"
                      stroke="currentColor"
                    >
                      <path
                        d="M8.09 8C8.3251 7.33167 8.78915 6.76811 9.39995 6.40913C10.0108 6.05016 10.7289 5.91894 11.4272 6.03871C12.1255 6.15849 12.7588 6.52152 13.2151 7.06353C13.6713 7.60553 13.9211 8.29152 13.92 9C13.92 11 10.92 12 10.92 12M11 16H11.01M21 11C21 16.5228 16.5228 21 11 21C5.47715 21 1 16.5228 1 11C1 5.47715 5.47715 1 11 1C16.5228 1 21 5.47715 21 11Z"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                    <span>Support</span>
                  </span>
                </a>
              </nav>
            </div>
          </div>
        </div>
      </div>
      <!-- profile -->
      <div class="flex flex-1 flex-col min-h-full h-screen md:pl-64">
        <div
          class="sticky top-0 z-10 flex md:flex-row items-center h-16 flex-shrink-0 bg-[#fff] shadow-sm px-4 md:px-6 lg:px-7"
        >
          <!-- mobile side nav toggle -->
          <button
            @click="open = !open"
            type="button "
            class="inline-block md:hidden pr-4 rounded-md text-gray-500 hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500"
          >
            <span class="sr-only">Open sidebar</span>
            <!-- Heroicon name: outline/bars-3 -->
            <svg
              class="h-6 w-6"
              xmlns="http://www.w3.org/2000/svg "
              fill="none "
              viewBox="0 0 24 24 "
              stroke-width="2 "
              stroke="currentColor "
              aria-hidden="true "
            >
              <path
                stroke-linecap="round "
                stroke-linejoin="round "
                d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5 "
              />
            </svg>
          </button>
          <!-- mobile side nav toggle -->

          <!-- logo section -->
          <div class="flex justify-start items-center space-x-4">
            <div>
              <img src="./assets/dfinity.svg" class="h-9" alt="" />
            </div>
            <div class="hidden lg:block">
              <p class="text-gray-900 text-base font-semibold">IC-Payroll</p>
            </div>
            <button
              @click="getTestTokens()"
              type="button"
              class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
            >
              Get loan
            </button>
            <!--div class="hidden md:block">
              <label
                for="accountType"
                class="block text-sm font-medium leading-6 text-gray-600"
                >AccountType</label
              >
              <div class="mt-1">
                <select
                  id="accountType"
                  name="accountType"
                  v-model="data.accountType"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option>Individual</option>
                  <option>Company</option>
                  <option>Employee</option>
                </select>
              </div>
            </div-->
          </div>
          <!-- logo section -->

          <!-- profile toggle -->
          <div class="flex flex-1 justify-end md:pl-4">
            <div class="ml-4 flex items-center md:ml-6">
              <button
                type="button "
                class="relative rounded-full bg-[#fff] p-1 text-gray-900 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-autom8-blue-800 focus:ring-offset-2"
              >
                <span class="sr-only">View notifications</span>
                <!-- Heroicon name: outline/bell -->
                <svg
                  class="h-6 w-6"
                  xmlns="http://www.w3.org/2000/svg "
                  fill="none "
                  viewBox="0 0 24 24 "
                  stroke-width="1.5 "
                  stroke="currentColor "
                  aria-hidden="true "
                >
                  <path
                    stroke-linecap="round "
                    stroke-linejoin="round "
                    d="M14.857 17.082a23.848 23.848 0 005.454-1.31A8.967 8.967 0 0118 9.75v-.7V9A6 6 0 006 9v.75a8.967 8.967 0 01-2.312 6.022c1.733.64 3.56 1.085 5.455 1.31m5.714
                                        0a24.255 24.255 0 01-5.714 0m5.714 0a3 3 0 11-5.714 0 "
                  />
                </svg>
                <span
                  class="absolute top-0 right-0 mr-1.5 mt-1 ring-2 ring-white rounded-full h-2 w-2 bg-red-500"
                ></span>
              </button>

              <!-- Profile dropdown -->
              <div class="relative ml-3">
                <div>
                  <button
                    @click="profileOpen = !profileOpen"
                    type="button "
                    class="flex max-w-xs items-center rounded-full bg-[#fff] text-sm focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                    id="user-menu-button
                                    "
                    aria-expanded="false "
                    aria-haspopup="true "
                  >
                    <span class="sr-only">Open user menu</span>
                    <img
                      class="h-8 w-8 rounded-full"
                      src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80 "
                      alt=" "
                    />
                  </button>
                </div>

                <!-- Dropdown menu, show/hide based on menu state. -->
                <div
                  x-cloak
                  v-show="profileOpen"
                  @click="profileOpen = !profileOpen"
                  enter="transition ease-out duration-100 "
                  enter-start="transform opacity-0 scale-95 "
                  enter-end="transform opacity-100
                                        scale-100 "
                  leave="transition ease-in duration-75 "
                  leave-start="transform opacity-100 scale-100 "
                  leave-end="transform opacity-0 scale-95 "
                  class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-[#fff] py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                  role="menu "
                  aria-orientation="vertical "
                  aria-labelledby="user-menu-button "
                  tabindex="-1 "
                >
                  <!-- Active: "bg-gray-100 ", Not Active: " " -->
                  <router-link
                    to="/home/owner-profile"
                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-autom8-blue-100 font-medium hover:text-white"
                    role="menuitem "
                    tabindex="-1 "
                    id="user-menu-item-0 "
                    >Profile</router-link
                  >

                  <!--a
                    href="# "
                    class="block px-4 py-2 text-sm text-gray-700 hover:bg-autom8-blue-100 font-medium hover:text-white"
                    role="menuitem "
                    tabindex="-1 "
                    id="user-menu-item-1 "
                    >Settings</a-->

                  <div
                    @click="logout"
                    class="block cursor-pointer px-4 py-2 text-sm text-gray-700 hover:bg-autom8-blue-100 font-medium hover:text-white"
                    role="menuitem "
                    tabindex="-1 "
                    id="user-menu-item-2 "
                  >
                    Sign out
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- profile toggle -->
        </div>
        <div class="h-screen bg-transparent">
          <router-view v-slot="{ Component, route }">
            <transition name="slide-left">
              <component :is="Component" :key="route.path" />
            </transition>
          </router-view>
        </div>
      </div>
    </div>

    <!-- add edit workflow -->
    <div
      x-cloak
      v-show="modal"
      x-on:modal-overlay.window="if ($event.detail.id == 'edit-workflow-modal') modal=true"
      class="relative z-30"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <!-- Background backdrop, show/hide based on modal state. -->
      <div
        enter="transition ease-out duration-300"
        enter-start="opacity-0"
        enter-end="opacity-100"
        leave="transition ease-in duration-200"
        leave-start="opacity-100"
        leave-end="opacity-0"
        class="fixed inset-0 bg-gray-700 bg-opacity-75 backdrop-filter backdrop-blur-sm transition-opacity"
      ></div>

      <div class="fixed inset-0 z-50 overflow-y-auto">
        <div
          class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
        >
          <!-- Modal panel, show/hide based on modal state. -->
          <div
            enter="transition ease-out duration-300"
            enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enter-end="opacity-100 translate-y-0 sm:scale-100"
            leave="transition ease-in duration-200"
            leave-start="opacity-100 translate-y-0 sm:scale-100"
            leave-end="opacity-0 translat-y-4 sm:translate-y-0 sm:scale-95"
            class="relative transform overflow-hidden rounded-lg bg-[#fff] text-left shadow-xl transition-all sm:my-8 w-full max-w-xl"
          >
            <div class="p-4 sm:px-5 sm:py-4 border-b border-gray-200">
              <h1 class="text-base font-semibold text-gray-700 m-0">
                Edit Workflow
              </h1>
            </div>
            <div class="p-4 sm:px-5 sm:py-5">
              <form>
                <div>
                  <div class="pb-6 pt-1">
                    <div class="grid grid-cols-3">
                      <div class="col-span-3">
                        <label
                          for="first-name"
                          class="block text-sm font-medium leading-6 text-gray-600"
                          >Name</label
                        >
                        <div class="mt-1">
                          <input
                            type="text"
                            name="first-name"
                            id="first-name"
                            autocomplete="given-name"
                            class="block w-full rounded-md border-0 py-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="flex items-center justify-end gap-x-3">
                  <button
                    type="button"
                    @click="modal = false"
                    class="inline-flex items-center rounded-md border border-gray-300 px-6 py-2 text-sm font-medium text-gray-500 bg-[#fff] hover:text-gray-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    class="rounded-md bg-autom8-blue-500 px-6 py-2 text-sm font-semibold text-white hover:bg-autom8-blue-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-autom8-blue-500"
                  >
                    Save
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- add import workflow -->
    <div
      x-cloak
      v-show="modal"
      x-on:modal-overlay.window="if ($event.detail.id == 'import-workflow-modal') modal=true"
      class="relative z-30"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <!-- Background backdrop, show/hide based on modal state. -->
      <div
        enter="transition ease-out duration-300"
        enter-start="opacity-0"
        enter-end="opacity-100"
        leave="transition ease-in duration-200"
        leave-start="opacity-100"
        leave-end="opacity-0"
        class="fixed inset-0 bg-gray-700 bg-opacity-75 backdrop-filter backdrop-blur-sm transition-opacity"
      ></div>

      <div class="fixed inset-0 z-50 overflow-y-auto">
        <div
          class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
        >
          <!-- Modal panel, show/hide based on modal state. -->
          <div
            enter="transition ease-out duration-300"
            enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enter-end="opacity-100 translate-y-0 sm:scale-100"
            leave="transition ease-in duration-200"
            leave-start="opacity-100 translate-y-0 sm:scale-100"
            leave-end="opacity-0 translat-y-4 sm:translate-y-0 sm:scale-95"
            class="relative transform overflow-hidden rounded-lg bg-[#fff] text-left shadow-xl transition-all sm:my-8 w-full max-w-xl"
          >
            <div class="p-4 sm:px-5 sm:py-4 border-b border-gray-200">
              <h1 class="text-base font-semibold text-gray-700 m-0">
                Import Workflow Config
              </h1>
            </div>
            <div>
              <form>
                <div class="p-4 sm:px-5 sm:py-5 border-b border-gray-200">
                  <div class="">
                    <div class="grid grid-cols-3 space-y-4">
                      <div class="col-span-3">
                        <label
                          for="choose-file"
                          class="block text-sm font-medium leading-6 text-gray-600"
                          >Choose File</label
                        >
                        <div
                          class="mt-1 flex justify-center rounded-lg border border-gray-200 px-6 py-2"
                        >
                          <div class="text-center">
                            <div
                              class="mt-0 flex text-sm leading-6 text-gray-500"
                            >
                              <label
                                for="file-upload"
                                class="relative cursor-pointer rounded-md bg-[#fff] font-semibold text-autom8-blue-500 focus-within:outline-none focus-within:ring-2 focus-within:ring-autom8-blue-300 focus-within:ring-offset-2 hover:text-autom8-blue-500"
                              >
                                <span>Click to upload</span>
                                <input
                                  id="file-upload"
                                  name="file-upload"
                                  type="file"
                                  class="sr-only"
                                />
                              </label>
                              <p class="pl-1">or drag and drop</p>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div class="col-span-full">
                        <div class="mt-0">
                          <textarea
                            id="about"
                            name="about"
                            rows="10"
                            class="block w-full rounded-md border border-gray-200 py-1.5 text-gray-500 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                          ></textarea>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  class="flex items-center justify-end gap-x-3 p-4 sm:px-5 sm:py-5"
                >
                  <button
                    type="button"
                    @click="modal = false"
                    class="inline-flex items-center rounded-md border border-gray-300 px-6 py-2 text-sm font-medium text-gray-500 bg-[#fff] hover:text-gray-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    class="rounded-md bg-autom8-blue-500 px-6 py-2 text-sm font-semibold text-white hover:bg-autom8-blue-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-autom8-blue-500"
                  >
                    Import
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- add export workflow -->
    <div
      x-cloak
      v-show="modal"
      x-on:modal-overlay.window="if ($event.detail.id == 'export-workflow-modal') modal=true"
      class="relative z-30"
      aria-labelledby="modal-title"
      role="dialog"
      aria-modal="true"
    >
      <!-- Background backdrop, show/hide based on modal state. -->
      <div
        enter="transition ease-out duration-300"
        enter-start="opacity-0"
        enter-end="opacity-100"
        leave="transition ease-in duration-200"
        leave-start="opacity-100"
        leave-end="opacity-0"
        class="fixed inset-0 bg-gray-700 bg-opacity-75 backdrop-filter backdrop-blur-sm transition-opacity"
      ></div>

      <div class="fixed inset-0 z-50 overflow-y-auto">
        <div
          class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
        >
          <!-- Modal panel, show/hide based on modal state. -->
          <div
            enter="transition ease-out duration-300"
            enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            enter-end="opacity-100 translate-y-0 sm:scale-100"
            leave="transition ease-in duration-200"
            leave-start="opacity-100 translate-y-0 sm:scale-100"
            leave-end="opacity-0 translat-y-4 sm:translate-y-0 sm:scale-95"
            class="relative transform overflow-hidden rounded-lg bg-[#fff] text-left shadow-xl transition-all sm:my-8 w-full max-w-xl"
          >
            <div class="p-4 sm:px-5 sm:py-4 border-b border-gray-200">
              <h1 class="text-base font-semibold text-gray-700 m-0">
                Export Workflow Config
              </h1>
            </div>
            <div>
              <form>
                <div class="p-4 sm:px-5 sm:py-5 border-b border-gray-200">
                  <div class="">
                    <div class="grid grid-cols-3 space-y-4">
                      <div class="col-span-full">
                        <div class="mt-0">
                          <textarea
                            id="about"
                            name="about"
                            rows="10"
                            class="block w-full rounded-md border border-gray-200 py-1.5 text-gray-500 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                          ></textarea>
                        </div>
                      </div>
                      <div class="col-span-full text-right">
                        <button
                          type="submit"
                          class="rounded-md bg-autom8-blue-50 px-5 py-2 text-sm font-semibold text-autom8-blue-500 hover:bg-autom8-blue-100 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-autom8-blue-500"
                        >
                          Copy
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <div
                  class="flex items-center justify-end gap-x-3 p-4 sm:px-5 sm:py-5"
                >
                  <button
                    type="button"
                    @click="modal = false"
                    class="inline-flex items-center rounded-md border border-gray-300 px-6 py-2 text-sm font-medium text-gray-500 bg-[#fff] hover:text-gray-500 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2 sm:w-auto"
                  >
                    Cancel
                  </button>
                  <button
                    type="submit"
                    class="rounded-md bg-autom8-blue-500 px-6 py-2 text-sm font-semibold text-white hover:bg-autom8-blue-600 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-autom8-blue-500"
                  >
                    Download Json
                  </button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 300ms ease-out;
}
.fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: transform 300ms ease-out;
}
.slide-enter, .slide-leave-to /* .slide-leave-active below version 2.1.8 */ {
  transform: translateX(-100%);
}
</style>
