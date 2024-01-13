<script setup>
import { ref } from "vue"

defineProps({
  msg: String,
})

const count = ref(0)
</script>

<template>
  <div class="rounded-lg w-[330px]">
    <label for="search" class="sr-only">Search</label>
    <div class="relative text-gray-400 focus-within:text-gray-600">
      <div
        class="pointer-events-none absolute inset-y-0 left-0 flex items-center pl-3"
      >
        <svg
          class="h-5 w-5"
          x-description="Heroicon name: mini/magnifying-glass"
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 20 20"
          fill="currentColor"
          aria-hidden="true"
        >
          <path
            fill-rule="evenodd"
            d="M9 3.5a5.5 5.5 0 100 11 5.5 5.5 0 000-11zM2 9a7 7 0 1112.452 4.391l3.328 3.329a.75.75 0 11-1.06 1.06l-3.329-3.328A7 7 0 012 9z"
            clip-rule="evenodd"
          ></path>
        </svg>
      </div>
      <input
        id="search"
        class="block w-full h-full rounded-lg border border-gray-300 dark:border-transparent bg-transparent py-2 pl-10 pr-3 leading-5 text-gray-900 placeholder-gray-500 focus:border-white dark:focus:border-transparent focus:outline-none focus:ring-2 focus:ring-white dark:focus:ring-transparent focus:ring-offset-2 focus:ring-offset-autom8-blue-600 sm:text-sm"
        placeholder="Search"
        type="search"
        name="search"
      />
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
