<script setup>
import { ref, watchEffect } from "vue";
import router from "../../router";
import { useAuthStore } from "../../store/auth";
const authStore = useAuthStore();
const filterOpen = ref(false);
const isLoading = ref(false);
let userlength = ref(0);
let users = ref([]);

watchEffect(async () => {
  isLoading.value = true;
  const res = await authStore.whoamiActor?.getEmployees();
  let usersArray = [];

  // Loop through the result and create an array of objects
  for (let i = 0; i < res.length; i++) {
    const data = res[i];
    usersArray.push(data);
  }

  // Assign the array of objects to the users ref
  users.value = usersArray;

  //get length
  userlength.value = usersArray.length;

  console.log("Users array:", usersArray);
  isLoading.value = false;
});

const gotoaddemployee = () => {
  router.push("/home/add-employee");
};
const employees = [
  {
    id: 1,
    name: "HarambeeApps",
    staffno: "VCF001",
    phone: "0583405830495834",
    position: "hr manager",
  },
  {
    id: 2,
    name: "BitPochi",
    staffno: "VCF001",
    phone: "0583405830495834",
    position: "hr manager",
  },
  {
    id: 3,
    name: "Bounty Safari",
    staffno: "VCF001",
    phone: "0583405830495834",
    position: "hr manager",
  },
];

// async function deleteUser(wallet) {
//   try {
//     const res = await authStore.whoamiActor?.remove_employee(wallet);
//     console.log("User deleted:", res);
//   } catch (error) {
//     console.error("Error deleting user:", error);
//   }
// }
</script>
<template>
  <main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div v-if="isLoading">
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
    <div v-else>
      <div class="mb-6">
        <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
          Employees
        </h2>
        <p class="text-sm sm:text-base text-gray-500 font-normal">
          Your current organizations and details
        </p>
      </div>
      <div class="bg-[#fff] border border-gray-100 shadow rounded-lg h-full">
        <div
          class="flex flex-col sm:flex-row sm:justify-between sm:items-center space-y-3 sm:space-y-0 px-3 py-4 border-b border-gray-100"
        >
          <div
            class="flex flex-col w-full sm:flex-row justify-between sm:items-center sm:space-x-3 space-y-3 sm:space-y-0"
          >
            <div class="rounded-lg w-full">
              <label for="search" class="sr-only">Search</label>
              <div class="relative text-gray-400 focus-within:text-gray-600">
                <div
                  class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
                >
                  <img src="../../assets/search.svg" alt="search" />
                </div>
                <input
                  id="search"
                  class="block w-full rounded-lg border border-gray-300 bg-[#fff] py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-500 focus:border-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-autom8-blue-600 sm:text-sm"
                  placeholder="Search"
                  type="search"
                  name="search"
                />
              </div>
            </div>

            <!-- filter section -->
            <div v-on:click.away="filterOpen = false" class="relative">
              <button
                @click="filterOpen = !filterOpen"
                type="button"
                class="inline-flex items-center justify-center sm:w-48 min-w-[130px] rounded-md border border-gray-300 bg-[#fff] px-3 py-2 text-sm space-x-2 font-medium leading-4 text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
              >
                <img src="../../assets/filter.svg" alt="filter" />
                <span>Apply Filter</span>
              </button>

              <!-- filter body -->
              <div
                v-cloak
                v-show="filterOpen"
                v-transition
                class="absolute right-0 z-10 mt-2 w-96 origin-top-right rounded-md bg-[#fff] py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
                role="menu"
                aria-orientation="vertical"
                aria-labelledby="user-menu-button"
                tabindex="-1"
              >
                <div class="px-3 py-3 space-y-2">
                  <div class="flex justify-between items-center">
                    <p class="text-sm text-gray-400">Filter by</p>
                    <button
                      class="cursor-pointer hover:bg-gray-100 p-2 rounded"
                      @click="open = false"
                    >
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-3 w-3"
                        version="1.0"
                        width="128.000000pt"
                        height="128.000000pt"
                        viewBox="0 0 128.000000 128.000000"
                        preserveAspectRatio="xMidYMid meet"
                      >
                        <g
                          transform="translate(0.000000,128.000000) scale(0.100000,-0.100000)"
                          fill="#94A0B2"
                          stroke="none"
                        >
                          <path
                            d="M29 1251 c-57 -57 -56 -58 233 -348 l262 -263 -262 -263 c-235 -236 -262 -266 -262 -295 0 -44 38 -82 82 -82 29 0 59 27 295 262 l263 262 263 -262 c236 -235 266 -262 295 -262 44 0 82 38 82 82 0 29 -27 59 -262 295 l-262 263 262 263 c289 290 290 291 233 348 -57 57 -58 56 -348 -233 l-263 -262 -263 262 c-290 289 -291 290 -348 233z"
                          />
                        </g>
                      </svg>
                    </button>
                  </div>
                  <div class="grid grid-cols-12 gap-2">
                    <div class="col-span-6">
                      <select
                        id="location"
                        name="location"
                        class="mt-1 block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-autom8-blue-500 focus:outline-none focus:ring-autom8-blue-500 sm:text-sm"
                      >
                        <option selected>Model</option>
                        <option>Isuzu</option>
                        <option>Toyota</option>
                        <option>Audi</option>
                      </select>
                    </div>
                    <div class="col-span-6">
                      <select
                        id="location"
                        name="location"
                        class="mt-1 block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-autom8-blue-500 focus:outline-none focus:ring-autom8-blue-500 sm:text-sm"
                      >
                        <option selected>Color</option>
                        <option>Red</option>
                        <option>White</option>
                        <option>Black</option>
                      </select>
                    </div>
                  </div>
                </div>
              </div>
              <!-- filter body -->
            </div>
            <!-- filter section -->

            <button
              type="button"
              class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
              @click="gotoaddemployee"
            >
              Add New
            </button>
          </div>
        </div>

        <div>
          <div v-if="users.length === 0">
            <div
              class="text-sm sm:text-base text-gray-500 font-normal text-center p-2 h-full"
            >
              No Employees Available
            </div>
          </div>
          <!-- table section -->
          <div v-else>
            <div class="flex flex-col">
              <div class="block">
                <div
                  class="block w-full align-middle overflow-x-auto scrollbar"
                >
                  <div class="md:rounded-b-lg w-full">
                    <table class="divide-y divide-gray-300 w-full">
                      <thead class="bg-gray-50">
                        <tr>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Employee Id
                          </th>
                          <th
                            scope="col"
                            class="py-3.5 pl-4 pr-3 text-left text-sm font-medium text-gray-500"
                          >
                            Email
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 text-left text-sm font-medium text-gray-500"
                          >
                            Phone Number
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 text-left text-sm font-medium text-gray-500"
                          >
                            Name
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 text-left text-sm font-medium text-gray-500"
                          >
                            Last Name
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 text-left text-sm font-medium text-gray-500"
                          >
                            Designation
                          </th>
                          <th
                            scope="col"
                            class="px-3 py-3.5 pr-4 sm:pr-6 text-right text-sm font-medium text-gray-500"
                          >
                            &nbsp;
                          </th>
                        </tr>
                      </thead>
                      <tbody class="divide-y divide-gray-200 bg-[#fff]">
                        <tr v-for="user in users" :key="user.phone_number">
                          <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm">
                            <div class="font-normal text-gray-500">
                              {{ user.employee_id }}
                            </div>
                          </td>
                          <td class="whitespace-nowrap py-4 pl-4 pr-3 text-sm">
                            <div class="font-normal text-gray-500">
                              {{ user.email_address }}
                            </div>
                          </td>
                          <td
                            class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                          >
                            <div class="font-normal text-gray-500">
                              {{ user.phone_number }}
                            </div>
                          </td>
                          <td
                            class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                          >
                            <div class="font-normal text-gray-500">
                              {{ user.first_name }}
                            </div>
                          </td>
                          <td
                            class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                          >
                            <div class="font-normal text-gray-500">
                              {{ user.last_name }}
                            </div>
                          </td>
                          <td
                            class="whitespace-nowrap px-3 py-4 text-sm text-gray-500"
                          >
                            <div class="font-normal text-gray-500">
                              {{ user.designation }}
                            </div>
                          </td>
                          <td
                            class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6"
                          >
                            <div
                              class="flex flex-row items-center justify-end space-x-4"
                            >
                              <button
                                type="button"
                                class="inline-flex items-center rounded bg-[#fff] px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                              >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="18"
                                  height="20"
                                  viewBox="0 0 18 20"
                                  fill="none"
                                >
                                  <path
                                    d="M12.3333 5.00002V4.33335C12.3333 3.39993 12.3333 2.93322 12.1517 2.5767C11.9919 2.2631 11.7369 2.00813 11.4233 1.84834C11.0668 1.66669 10.6001 1.66669 9.66667 1.66669H8.33333C7.39991 1.66669 6.9332 1.66669 6.57668 1.84834C6.26308 2.00813 6.00811 2.2631 5.84832 2.5767C5.66667 2.93322 5.66667 3.39993 5.66667 4.33335V5.00002M7.33333 9.58335V13.75M10.6667 9.58335V13.75M1.5 5.00002H16.5M14.8333 5.00002V14.3334C14.8333 15.7335 14.8333 16.4336 14.5608 16.9683C14.3212 17.4387 13.9387 17.8212 13.4683 18.0609C12.9335 18.3334 12.2335 18.3334 10.8333 18.3334H7.16667C5.76654 18.3334 5.06647 18.3334 4.53169 18.0609C4.06129 17.8212 3.67883 17.4387 3.43915 16.9683C3.16667 16.4336 3.16667 15.7335 3.16667 14.3334V5.00002"
                                    stroke="#F0372B"
                                    stroke-width="1.66667"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </button>
                              <button
                                type="button"
                                class="inline-flex items-center rounded bg-[#fff] px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                                x-data="{id:'import-workflow-modal'}"
                                x-on:click="$dispatch('modal-overlay',{id})"
                              >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="20"
                                  height="18"
                                  viewBox="0 0 20 18"
                                  fill="none"
                                  stroke="currentColor"
                                >
                                  <path
                                    d="M6.66602 13.1667L9.99935 16.5M9.99935 16.5L13.3327 13.1667M9.99935 16.5V9M16.666 12.9524C17.6839 12.1117 18.3327 10.8399 18.3327 9.41667C18.3327 6.88536 16.2807 4.83333 13.7493 4.83333C13.5673 4.83333 13.3969 4.73833 13.3044 4.58145C12.2177 2.73736 10.2114 1.5 7.91602 1.5C4.46424 1.5 1.66602 4.29822 1.66602 7.75C1.66602 9.47175 2.36222 11.0309 3.48847 12.1613"
                                    stroke-width="1.67"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </button>
                              <button
                                type="button"
                                class="inline-flex items-center rounded bg-[#fff] px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                                x-data="{id:'export-workflow-modal'}"
                                x-on:click="$dispatch('modal-overlay',{id})"
                              >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="20"
                                  height="18"
                                  viewBox="0 0 20 18"
                                  fill="none"
                                  stroke="currentColor"
                                >
                                  <path
                                    d="M6.66602 12.3333L9.99935 9M9.99935 9L13.3327 12.3333M9.99935 9V16.5M16.666 12.9524C17.6839 12.1117 18.3327 10.8399 18.3327 9.41667C18.3327 6.88536 16.2807 4.83333 13.7493 4.83333C13.5673 4.83333 13.3969 4.73833 13.3044 4.58145C12.2177 2.73736 10.2114 1.5 7.91602 1.5C4.46424 1.5 1.66602 4.29822 1.66602 7.75C1.66602 9.47175 2.36222 11.0309 3.48847 12.1613"
                                    stroke-width="1.67"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </button>
                              <a
                                href="./workflow-config.html"
                                class="inline-flex items-center rounded bg-[#fff] px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                              >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="16"
                                  height="16"
                                  viewBox="0 0 16 16"
                                  fill="none"
                                  stroke="currentColor"
                                >
                                  <path
                                    d="M8.00065 2.99998V1.33331M8.00065 2.99998C7.08018 2.99998 6.33398 3.74617 6.33398 4.66665C6.33398 5.58712 7.08018 6.33331 8.00065 6.33331M8.00065 2.99998C8.92113 2.99998 9.66732 3.74617 9.66732 4.66665C9.66732 5.58712 8.92113 6.33331 8.00065 6.33331M3.00065 13C3.92113 13 4.66732 12.2538 4.66732 11.3333C4.66732 10.4128 3.92113 9.66665 3.00065 9.66665M3.00065 13C2.08018 13 1.33398 12.2538 1.33398 11.3333C1.33398 10.4128 2.08018 9.66665 3.00065 9.66665M3.00065 13V14.6666M3.00065 9.66665V1.33331M8.00065 6.33331V14.6666M13.0007 13C13.9211 13 14.6673 12.2538 14.6673 11.3333C14.6673 10.4128 13.9211 9.66665 13.0007 9.66665M13.0007 13C12.0802 13 11.334 12.2538 11.334 11.3333C11.334 10.4128 12.0802 9.66665 13.0007 9.66665M13.0007 13V14.6666M13.0007 9.66665V1.33331"
                                    stroke-width="1.67"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </a>
                              <button
                                type="button"
                                class="inline-flex items-center rounded bg-[#fff] px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                                x-data="{id:'edit-workflow-modal'}"
                                x-on:click="$dispatch('modal-overlay',{id})"
                              >
                                <svg
                                  xmlns="http://www.w3.org/2000/svg"
                                  width="19"
                                  height="19"
                                  viewBox="0 0 19 19"
                                  fill="none"
                                  stroke="currentColor"
                                >
                                  <path
                                    d="M1.39735 15.0964C1.43564 14.7518 1.45478 14.5795 1.50691 14.4185C1.55316 14.2756 1.61851 14.1396 1.70118 14.0142C1.79436 13.8729 1.91694 13.7504 2.16209 13.5052L13.1673 2.49999C14.0878 1.57951 15.5802 1.57951 16.5007 2.49999C17.4211 3.42046 17.4211 4.91285 16.5007 5.83332L5.49542 16.8386C5.25027 17.0837 5.1277 17.2063 4.98639 17.2995C4.86102 17.3821 4.72506 17.4475 4.58219 17.4937C4.42115 17.5459 4.24887 17.565 3.90429 17.6033L1.08398 17.9167L1.39735 15.0964Z"
                                    stroke-width="1.66667"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                  />
                                </svg>
                              </button>
                            </div>
                          </td>
                        </tr>
                      </tbody>
                    </table>

                    <nav
                      class="flex items-center justify-between px-3 pr-3 sm:pr-6 border-t border-gray-300 py-3"
                      aria-label="Pagination"
                    >
                      <div class="block">
                        <p class="text-sm text-gray-700">
                          Showing
                          <span class="font-medium">1</span> to
                          <span class="font-medium">2</span> of
                          <span class="font-medium">2</span> results
                        </p>
                      </div>
                      <div class="flex justify-between sm:justify-end">
                        <!-- Active:  class="px-4 py-2 text-sm font-medium text-gray-700 bg-[#fff] border border-gray-300 rounded-md hover:bg-gray-50"  -->
                        <a
                          href="#"
                          class="px-4 py-2 text-sm font-medium text-gray-700 bg-[#fff] border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                        >
                          Previous
                        </a>
                        <a
                          href="#"
                          class="px-4 py-2 ml-3 text-sm font-medium text-gray-700 bg-[#fff] border border-gray-300 rounded-md cursor-not-allowed hover:bg-gray-50"
                        >
                          Next
                        </a>
                      </div>
                    </nav>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- table section -->
        </div>
      </div>
    </div>
  </main>
</template>
