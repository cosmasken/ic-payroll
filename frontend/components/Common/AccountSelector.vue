<script setup></script>
<template>
  <div class="mt-6 grid grid-cols-1 gap-4">
    <a
      href="#"
      class="flex w-full items-center justify-left gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
    >
      <span class="text-sm font-semibold leading-6">Account Type</span>
      <select
        id="accounttype"
        name="accounttype"
        class="mt-2 block w-full rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-autom8-blue-500 sm:text-sm sm:leading-6"
      >
        <option>Individual</option>
        <option selected="">Business</option>
      </select>
    </a>
  </div>
</template>
