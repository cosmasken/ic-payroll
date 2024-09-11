<script setup>
import { ref, watchEffect } from "vue";
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
</script>
<template>
  <div>
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
              <!-- Heroicon name: outline/x-mark -->
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
                <!-- Heroicon name: outline/home -->
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
                  <!-- Heroicon name: outline/home -->
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
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Organizations</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/departments"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Departments</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/designations"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
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
                  <!-- Heroicon name: outline/home -->
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
                    <!-- Heroicon name: outline/home -->
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
                    <!-- Heroicon name: outline/home -->
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
                  <!-- Heroicon name: outline/home -->
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
                    <span>Payroll $ Salaries</span>
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
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>One Time Payments</span>
                    </span>
                  </router-link>
                  <router-link
                    to="/home/transactions"
                    class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Transactions</span>
                    </span>
                  </router-link>
                  <router-link
                    to="/home/all-salary"
                    class="text-gray-700 bg-gray-50 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>All Salaries</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/deductions"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Deductions</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/payslips"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Payslips</span>
                    </span>
                  </router-link>
                </div>
              </div>
              <div class="space-y-1">
                <a
                  @click="leavesOpen = !leavesOpen"
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  <!-- Heroicon name: outline/home -->
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
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>All Leaves</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/leave-application"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Leave Application</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/leave-settings"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Leave Settings</span>
                    </span>
                  </router-link>
                </div>
              </div>
              <div class="space-y-1">
                <a
                  @click="assetsOpen = !assetsOpen"
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  <!-- Heroicon name: outline/home -->
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
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Assigned Assets</span>
                    </span>
                  </router-link>

                  <router-link
                    to="/home/assign-assets"
                    class="text-gray-500 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 py-2 text-sm font-medium rounded-md"
                  >
                    <!-- Heroicon name: outline/home -->
                    <span class="flex items-center">
                      <span>Assign Assets</span>
                    </span>
                  </router-link>
                </div>
              </div>
            </nav>
            <nav class="mt-4 flex-1 space-y-2 pt-2">
              <a
                href="javascript:void(0) "
                class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
              >
                <!-- Heroicon name: outline/home -->
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
    <div class="hidden md:fixed md:inset-y-0 md:flex md:w-64 md:flex-col z-20">
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
                  <!-- Your icon here -->
                  <span>{{ link.text }}</span>
                </span>
              </router-link>

              <div class="space-y-1">
                <a
                  @click="organogramOpen = !organogramOpen"
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  <!-- Heroicon name: outline/home -->
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
                      <!-- Your icon here -->
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
                  <!-- Heroicon name: outline/home -->
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
                      <!-- Your icon here -->
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
                  <!-- Heroicon name: outline/home -->
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
                      <!-- Your icon here -->
                      <span>{{ link.text }}</span>
                    </span>
                  </router-link>
                </div>
              </div>

              <div class="space-y-1">
                <a
                  @click="leavesOpen = !leavesOpen"
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  <!-- Heroicon name: outline/home -->
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
                      <!-- Your icon here -->
                      <span>{{ link.text }}</span>
                    </span>
                  </router-link>
                </div>
              </div>

              <div class="space-y-1">
                <a
                  @click="assetsOpen = !assetsOpen"
                  href="javascript:void(0) "
                  class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
                >
                  <!-- Heroicon name: outline/home -->
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
                      <!-- Your icon here -->
                      <span>{{ link.text }}</span>
                    </span>
                  </router-link>
                </div>
              </div>
            </nav>
            <nav class="mt-4 flex-1 space-y-2 pt-2">
              <a
                href="javascript:void(0) "
                class="text-gray-700 hover:bg-gray-50 hover:text-gray-900 group flex items-center justify-between px-3 lg:px-4 py-2 text-sm font-medium rounded-md"
              >
                <!-- Heroicon name: outline/home -->
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
  </div>
</template>
