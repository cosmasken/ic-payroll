<script setup>
import { ref, watchEffect } from "vue";
import Searchbar from "../components/Searchbar.vue";
import router from "../router/";
import { fromList, toList, fromOptional, toOptional } from "../utils/idl.js";
import { ChevronLeftIcon, ChevronRightIcon } from "@heroicons/vue/20/solid";
import { useAuthStore } from "../store/auth";
import {
  Dialog,
  DialogPanel,
  DialogTitle,
  TransitionChild,
  TransitionRoot,
} from "@headlessui/vue";
import { CheckIcon } from "@heroicons/vue/24/outline";

const open = ref(true);
const authStore = useAuthStore();
let response = ref(0);
let userlength = ref(0);
let users = ref([]);

watchEffect(async () => {
  try {
    const res = await authStore.whoamiActor?.getMyContacts();
    let usersArray = [];
    console.log("backend array:", usersArray);

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
  } catch (error) {
    console.error("Error fetching users list:", error);
  }
});

const isEmpty = ref(true);

const gotoaddemployee = () => {
  router.push("/home/add-employee");
};

const userData = ref({
  name: "John Doe",
  email: "",
  email_notifications: true,
  phone: "",
  phone_notifications: false,
  wallet: "0x1234567890",
});

async function deleteUser(wallet) {
  try {
    const res = await authStore.whoamiActor?.deleteUser(wallet);
    console.log("User deleted:", res);
  } catch (error) {
    console.error("Error deleting user:", error);
  }
}
//import data by pointing users to static employee data for now
async function importdata() {
  try {
    const res = await authStore.whoamiActor?.getMyContacts();
    let usersArray = [];

    // Loop through the result and create an array of objects
    for (let i = 0; i < res.length; i++) {
      const [userId, userData] = res[i];
      usersArray.push({ userId, ...userData });
    }

    // Assign the array of objects to the users ref
    users.value = usersArray;

    console.log("Users array:", usersArray);
  } catch (error) {
    console.error("Error fetching users list:", error);
  }
}

async function viewUser(name, email, phone, wallet) {
  try {
    open.value = true;
    userData.name.value = name;
    userData.email.value = email;
    userData.phone.value = phone;
    userData.wallet.value = wallet;
    //const res = await authStore.whoamiActor?.getUser(user);
    console.log("User:", res);
  } catch (error) {
    console.error("Error fetching user:", error);
  }
}
</script>
<template>
  <div class="p-5 flex flex-col">
    <div class="flex flex-row justify-between items-center">
      <Searchbar />
      <div class="flex flex-row space-x-5">
        <button
          @click="gotoaddemployee"
          class="rounded-[10px] cursor-pointer flex flex-row bg-[#7152F3] p-3 items-center space-x-[10px]"
        >
          <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
          <p class="text-base font-light text-white">Add New</p>
        </button>
        <div
          @click="importdata"
          class="rounded-[10px] cursor-pointer flex flex-row bg-[#7152F3] p-3 items-center space-x-[10px]"
        >
          <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
          <p class="text-base font-light text-white">Refresh Data</p>
        </div>
      </div>
    </div>
    <!--div v-if="users.length === 0"
 class="animate-spin rounded-full justify-center h-10 w-10 border-t-2 border-b-2 border-gray-900 dark:border-white">


</div-->
    <div v-if="users.length === 0" class="mx-auto mt-10">
      <div class="flex flex-col items-center">
        <div class="w-1/4 h-1/4">
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
              d="M6 6.878V6a2.25 2.25 0 0 1 2.25-2.25h7.5A2.25 2.25 0 0 1 18 6v.878m-12 0c.235-.083.487-.128.75-.128h10.5c.263 0 .515.045.75.128m-12 0A2.25 2.25 0 0 0 4.5 9v.878m13.5-3A2.25 2.25 0 0 1 19.5 9v.878m0 0a2.246 2.246 0 0 0-.75-.128H5.25c-.263 0-.515.045-.75.128m15 0A2.25 2.25 0 0 1 21 12v6a2.25 2.25 0 0 1-2.25 2.25H5.25A2.25 2.25 0 0 1 3 18v-6c0-.98.626-1.813 1.5-2.122"
            />
          </svg>
        </div>
        <p class="text-accentgray text-lg font-light mt-5">No Contacts Found</p>
      </div>
    </div>

    <div v-else>
      <!-- Table-->
      <div class="flow-root">
        <div class="overflow-x-auto">
          <div
            class="inline-block min-w-full border-b border-gray-300 align-middle"
          >
            <table class="min-w-full divide-y divide-gray-300">
              <thead>
                <tr>
                  <th
                    scope="col"
                    class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Name
                  </th>
                  <!--th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  ID
                </th-->
                  <th
                    scope="col"
                    class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Email
                  </th>
                  <th
                    scope="col"
                    class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Phone
                  </th>
                  <th
                    scope="col"
                    class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Currency
                  </th>
                  <th
                    scope="col"
                    class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Wallet
                  </th>

                  <th
                    scope="col"
                    class="relative pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                  >
                    Action
                  </th>
                </tr>
              </thead>
              <tbody class="divide-y divide-gray-300">
                <tr v-for="person in users" :key="person.id">
                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    {{ person.name }}
                  </td>
                  <!--td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.id }}
                </td-->
                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    {{ person.email_address }}
                  </td>
                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    {{ person.phone_number }}
                  </td>
                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    ckBtc
                  </td>
                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    {{ person.wallet }}
                  </td>

                  <td
                    class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                  >
                    <div class="flex flex-row space-x-[10px]">
                      <div
                        @click="
                          viewUser(
                            person.name,
                            person.email_address,
                            person.phone_number,
                            person.wallet
                          )
                        "
                        class="cursor-pointer"
                      >
                        <img src="../assets/view.png" alt="" class="w-6 h-6" />
                      </div>
                      <div
                        @click="deleteUser(person.wallet)"
                        class="cursor-pointer"
                      >
                        <img src="../assets/trash.png" alt="" class="w-6 h-6" />
                      </div>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <div class="flex flex-row justify-between pt-[14px] items-center">
        <div class="flex flex-row space-x-5 items-center">
          <p class="text-accentgray text-sm leading-[22px] font-light">
            Showing
          </p>
          <div
            class="rounded-[10px] border border-bordercolor flex flex-row h-[46px] w-[76px] items-center justify-around"
          >
            <p class="text-accentgray text-sm leading-[22px] font-light">
              {{ userlength }}
            </p>
            <img src="../assets/direction-down 01.png" alt="" class="w-6 h-6" />
          </div>
        </div>

        <div>
          <p
            class="text-accentgray dark:text-white text-sm leading-[22px] font-light"
          >
            Showing
            {{ " " }}
            <span class="font-medium">1</span>
            {{ " " }}
            to
            {{ " " }}
            <span class="font-medium">{{ userlength }}</span>
            {{ " " }}
            out of
            {{ " " }}
            <span class="font-medium">{{ userlength }}</span>
            {{ " " }}
            Records
          </p>
        </div>

        <div>
          <nav
            class="isolate inline-flex -space-x-px rounded-md shadow-sm"
            aria-label="Pagination"
          >
            <a
              href="#"
              class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
            >
              <span class="sr-only">Previous</span>
              <ChevronLeftIcon class="h-5 w-5" aria-hidden="true" />
            </a>
            <!-- Current: "z-10 bg-indigo-600 text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600", Default: "text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:outline-offset-0" -->
            <a
              href="#"
              aria-current="page"
              class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset focus-visible:outline-[#7152F3]"
              >1</a
            >
            <a
              href="#"
              class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset focus-visible:outline-[#7152F3]"
              >2</a
            >
            <a
              href="#"
              class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
              >3</a
            >
            <span
              class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0"
              >...</span
            >

            <a
              href="#"
              class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
              >9</a
            >
            <a
              href="#"
              class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
            >
              <span class="sr-only">Next</span>
              <ChevronRightIcon class="h-5 w-5" aria-hidden="true" />
            </a>
          </nav>
        </div>
      </div>
      <TransitionRoot as="template" :show="open">
        <Dialog as="div" class="relative z-10" @close="open = false">
          <TransitionChild
            as="template"
            enter="ease-out duration-300"
            enter-from="opacity-0"
            enter-to="opacity-100"
            leave="ease-in duration-200"
            leave-from="opacity-100"
            leave-to="opacity-0"
          >
            <div
              class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
            />
          </TransitionChild>

          <div class="fixed inset-0 z-10 w-screen overflow-y-auto">
            <div
              class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
            >
              <TransitionChild
                as="template"
                enter="ease-out duration-300"
                enter-from="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                enter-to="opacity-100 translate-y-0 sm:scale-100"
                leave="ease-in duration-200"
                leave-from="opacity-100 translate-y-0 sm:scale-100"
                leave-to="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
              >
                <DialogPanel
                  class="relative transform overflow-hidden rounded-lg bg-white px-4 pb-4 pt-5 text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg sm:p-6"
                >
                  <div>
                    <div
                      class="mx-auto flex h-12 w-12 items-center justify-center rounded-full bg-green-100"
                    >
                      <CheckIcon
                        class="h-6 w-6 text-green-600"
                        aria-hidden="true"
                      />
                    </div>
                    <div class="mt-3 text-center sm:mt-5">
                      <DialogTitle
                        as="h3"
                        class="text-base font-semibold leading-6 text-gray-900"
                        >Payment successful</DialogTitle
                      >
                      <div class="mt-2">
                        <p class="text-sm text-gray-500">{{ userData.name }}</p>
                        <p class="text-sm text-gray-500">
                          {{ userData.wallet }}
                        </p>
                      </div>
                    </div>
                  </div>
                  <div
                    class="mt-5 sm:mt-6 sm:grid sm:grid-flow-row-dense sm:gap-3"
                  >
                    <!--button type="button" class="inline-flex w-full justify-center rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 sm:col-start-2" @click="open = false">Deactivate</button-->
                    <button
                      type="button"
                      class="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:col-start-1 sm:mt-0"
                      @click="open = false"
                      ref="cancelButtonRef"
                    >
                      Close
                    </button>
                  </div>
                </DialogPanel>
              </TransitionChild>
            </div>
          </div>
        </Dialog>
      </TransitionRoot>
    </div>
  </div>
</template>
