<script setup>
import { ref } from "vue";
import DatePicker from "../Common/DatePicker.vue";
const filterOpen = ref(false);

const organizations = [
  {
    id: 1,
    name: "HarambeeApps",
  },
  {
    id: 2,
    name: "BitPochi",
  },
  {
    id: 3,
    name: "Bounty Safari",
  },
];

const gender = [
  {
    id: 1,
    name: "Male",
  },
  {
    id: 2,
    name: "Female",
  },
];

const departments = [
  {
    id: 1,
    name: "Hr",
  },
  {
    id: 2,
    name: "Software Deveopment",
  },
  {
    id: 3,
    name: "Technical Support",
  },
];

const designation = [
  {
    id: 1,
    name: "Hr Manager",
  },
  {
    id: 2,
    name: "Software Developer",
  },
  {
    id: 3,
    name: "Full Stack Developer",
  },
  {
    id: 4,
    name: "Front End Developer",
  },
  {
    id: 5,
    name: "Back End Developer",
  },
];

const employeeType = [
  {
    id: 1,
    name: "Consultant",
  },
  {
    id: 2,
    name: "Fixed Type",
  },
  {
    id: 3,
    name: "Contract",
  },
  {
    id: 4,
    name: "Gig",
  },
];
const jobGroup = [
  {
    id: 1,
    name: "A1",
  },
  {
    id: 2,
    name: "A2",
  },
  {
    id: 3,
    name: "A3",
  },
  {
    id: 4,
    name: "A4",
  },
];

const role = [
  {
    id: 1,
    name: "Administrator",
  },
  {
    id: 2,
    name: "Hr Manager",
  },
  {
    id: 3,
    name: "Finance Manager",
  },
  {
    id: 4,
    name: "Employee",
  },
  {
    id: 4,
    name: "Intern",
  },
];
</script>
<template>
  <main
    class="flex flex-col min-h-full h-screen px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div class="mb-6 flex flex-row justify-between">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Add Employee
      </h2>
      <button
        type="button"
        class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
      >
        Import Employee
      </button>
    </div>
    <!-- title section -->
    <!-- table section -->
    <div>
      <div class="flex flex-col space-y-3 lg:mb-9">
        <div
          class="container grid grid-cols-1 lg:grid-cols-6 w-full space-y-5 lg:space-y-0 lg:space-x-5"
        >
          <div class="rounded-lg lg:col-span-4">
            <div class="pb-4 border-b border-[#E4EBEF]">
              <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
                Basic Info
              </h4>
            </div>

            <div
              class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-4 gap-5 mt-4"
            >
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >First Name</label
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
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Last name</label
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
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Phone</label
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
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Email</label
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
              <div class="lg:col-span-2">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Joining Date</label
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
              <div class="lg:col-span-2">
                <label
                  for="gender"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Gender</label
                >
                <div class="mt-1">
                  <select
                    id="gender"
                    name="gender"
                    class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                  >
                    <option v-for="org in gender" :key="org.id">
                      {{ org.name }}
                    </option>
                  </select>
                </div>
              </div>
              <div class="lg:col-span-4">
                <label
                  for="first-name"
                  class="block text-sm font-medium leading-6 text-gray-600"
                  >Person with Diability</label
                >
                <div class="mt-1">
                  <input type="checkbox" class="checkbox rounded-md" />
                </div>
              </div>
            </div>
          </div>
          <div class="rounded-lg lg:col-span-2">
            <div class="pb-4 border-b border-[#E4EBEF]">
              <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
                Profile Photo
              </h4>
            </div>

            <div class="bg-[#fff] md:p-5 rounded-md mt-4">
              <div
                class="border md:h-[300px] p-2 md:p-5 border-dashed border-autom8-blue-500 bg-[#f8fafb] grid items-center justify-center text-center mt-4 rounded-md"
              >
                <div class="flex flex-col">
                  <img
                    class="h-8 w-auto"
                    src="../../assets/upload.svg"
                    alt="autom8"
                  />

                  <p>Upload a File</p>
                </div>

                <button
                  type="button"
                  class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
                >
                  Upload a File
                </button>
              </div>
            </div>
          </div>
        </div>

        <div class="container w-full border-b mb-4 border-[#E4EBEF]">
          <div class="pb-4 border-b border-[#E4EBEF]">
            <h4 class="text-lg lg:text-xl font-semibold text-gray-900">
              Company Relations
            </h4>
          </div>
          <div
            class="grid grid-cols-1 bg-[#fff] p-2 lg:p-5 rounded-md lg:grid-cols-6 gap-5 mt-4"
          >
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Organization</label
              >
              <div class="mt-1">
                <select
                  id="organization"
                  name="organization"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in organizations" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Department</label
              >
              <div class="mt-1">
                <select
                  id="departments"
                  name="departments"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in departments" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Designation</label
              >
              <div class="mt-1">
                <select
                  id="designation"
                  name="designation"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in designation" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="employeetype"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Employee Type</label
              >
              <div class="mt-1">
                <select
                  id="employeetype"
                  name="employeetype"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in employeeType" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Job Group</label
              >
              <div class="mt-1">
                <select
                  id="jobGroup"
                  name="jobGroup"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in jobGroup" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="reports-to"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Reports To</label
              >
              <div class="mt-1">
                <input
                  type="text"
                  name="reports-to"
                  id="first-name"
                  autocomplete="given-name"
                  class="block w-full rounded-md border-0 py-2 text-gray-900 shadow-xs ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                />
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Gross Salary</label
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
            <div class="lg:col-span-2">
              <label
                for="role"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Role</label
              >
              <div class="mt-1">
                <select
                  id="role"
                  name="role"
                  class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
                >
                  <option v-for="org in role" :key="org.id">
                    {{ org.name }}
                  </option>
                </select>
              </div>
            </div>
            <div class="lg:col-span-2">
              <label
                for="first-name"
                class="block text-sm font-medium leading-6 text-gray-600"
                >Permissions</label
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
        <div class="">
          <button
            type="button"
            class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
          >
            Save
          </button>
        </div>
      </div>
    </div>
    <!-- table section -->
  </main>
  <!-- add new workflow -->
  <div
    x-cloak
    x-data="{modal:false}"
    x-show="modal"
    x-on:modal-overlay.window="if ($event.detail.id == 'new-workflow-modal') modal=true"
    class="relative z-30"
    aria-labelledby="modal-title"
    role="dialog"
    aria-modal="true"
  >
    <!-- Background backdrop, show/hide based on modal state. -->
    <div
      x-transition:enter="transition ease-out duration-300"
      x-transition:enter-start="opacity-0"
      x-transition:enter-end="opacity-100"
      x-transition:leave="transition ease-in duration-200"
      x-transition:leave-start="opacity-100"
      x-transition:leave-end="opacity-0"
      class="fixed inset-0 bg-gray-700 bg-opacity-75 backdrop-filter backdrop-blur-sm transition-opacity"
    ></div>

    <div class="fixed inset-0 z-50 overflow-y-auto">
      <div
        class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0"
      >
        <!-- Modal panel, show/hide based on modal state. -->
        <div
          x-transition:enter="transition ease-out duration-300"
          x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
          x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100"
          x-transition:leave="transition ease-in duration-200"
          x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100"
          x-transition:leave-end="opacity-0 translat-y-4 sm:translate-y-0 sm:scale-95"
          class="relative transform overflow-hidden rounded-lg bg-[#fff] text-left shadow-xl transition-all sm:my-8 w-full max-w-xl"
        >
          <div class="p-4 sm:px-5 sm:py-4 border-b border-gray-200">
            <h1 class="text-base font-semibold text-gray-700 m-0">Add New</h1>
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
                        >Address</label
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
</template>
