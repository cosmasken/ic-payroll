<script setup>
import { ref } from "vue";
import EmployeeView from "./EmployeeView.vue";
import Overview from "./Overview.vue";
import Address from "./Address.vue";
import PersonalInformation from "./PersonalInformation.vue";
import PaymentInformation from "./PaymentInformation.vue";
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
</script>
<template>
  <main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6 h-screen"
  >
    <div class="mb-6">
      <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Employee Profile
      </h2>
      <p class="text-sm sm:text-base text-gray-500 font-normal">
        Details for employee id : VCF 0003
      </p>
    </div>
    <!-- title section -->
    <!-- table section -->
    <div class="h-full w-full flex flex-col space-y-5">
      <div class="grid grid-cols-1 lg:grid-cols-3 gap-5">
        <EmployeeView />
        <Overview />
        <Address />
      </div>
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-5">
        <PersonalInformation />
        <PaymentInformation />
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
