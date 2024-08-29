<script setup>
import { defineProps } from "vue";

const props = defineProps({
  title: String,
});
</script>
<template>
  <div class="mb-6 flex flex-col sm:flex-row justify-between">
    <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
      {{ title }}
    </h2>
    <button
      type="button"
      class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
    >
      Add New
    </button>
  </div>
</template>
