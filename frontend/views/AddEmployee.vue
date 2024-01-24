<template>
  <form>
    <div class="space-y-12 p-5">
      <div class="border-b border-gray-900/10 pb-12">
        <h2
          class="text-base font-semibold leading-7 text-gray-900 dark:text-white"
        >
          Personal Information
        </h2>
        <p class="mt-1 text-sm leading-6 text-gray-600 dark:text-white">
          Use a permanent address where user can receive mail.
        </p>

        <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
          <div class="sm:col-span-3">
            <label
              for="first-name"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >First name</label
            >
            <div class="mt-2">
              <input
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="given-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label
              for="last-name"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Last name</label
            >
            <div class="mt-2">
              <input
                type="text"
                name="last-name"
                id="last-name"
                autocomplete="family-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label
              for="designation"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Designation</label
            >
            <div class="mt-2">
              <input
                type="text"
                name="designation"
                id="designation"
                autocomplete="designation"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-4">
            <label
              for="email"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Email address</label
            >
            <div class="mt-2">
              <input
                id="email"
                name="email"
                type="email"
                autocomplete="email"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="sm:col-span-3">
            <label
              for="country"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Country</label
            >
            <div class="mt-2">
              <select
                id="country"
                name="country"
                autocomplete="country-name"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
              >
                <option>United States</option>
                <option>Kenya</option>
                <option>Uganda</option>
                <option>Nigeria</option>
              </select>
            </div>
          </div>

          <div class="col-span-full">
            <label
              for="wallet-address"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Wallet address</label
            >
            <div class="mt-2">
              <input
                type="text"
                name="street-address"
                id="wallet-address"
                autocomplete="wallet-address"
                class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
              />
            </div>
          </div>

          <div class="col-span-full">
            <label
              for="wallet-address"
              class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
              >Wallet address</label
            >

            {{ response }} is address
          </div>
        </div>
      </div>
    </div>

    <div class="mt-6 flex items-center justify-end gap-x-6 p-5">
      <button
        type="button"
        class="text-sm font-semibold leading-6 text-gray-900 dark:text-white"
      >
        Cancel
      </button>
      <button
        @click="getBalance()"
        class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
      >
        Save
      </button>
    </div>
  </form>
</template>

<script setup></script>
