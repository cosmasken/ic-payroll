<script setup>
import { ref } from "vue"
defineProps({
  label: String,
  placeholder: String,
})
</script>

<template>
  <div>
    <label for="email" class="sr-only">Email</label>
    <input
      type="email"
      name="email"
      id="email"
      class="block w-full rounded-[10px] border border-[#A2A1A833]/10 py-4 pl-4 pr-5 text-textcolor dark:text-darktextcolor ring-1 ring-inset ring-[#A2A1A8CC]/80 placeholder:text-[#A2A1A8CC]/80 focus:ring-2 focus:ring-inset focus:ring-[#A2A1A8CC]/80 sm:text-base sm:leading-6 font-light"
      :placeholder="placeholder"
    />
  </div>
</template>

<style scoped></style>
