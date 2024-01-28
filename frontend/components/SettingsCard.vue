<script setup>
import { BeakerIcon, ChevronDownIcon } from "@heroicons/vue/24/solid";
defineProps({
  heading: String,
  subtitle: String,
  btnText: String,
  type: String,
  remote: String,
  salary: String,
});
</script>
<template>
  <div class="flex flex-row justify-between py-5">
    <div class="flex flex-col">
      <p class="text-[#16151C] dark:text-white text-base  font-semibold">
        {{ heading }}
      </p>
      <p class="text-[#A2A1A8]  text-base  font-semibold">
        {{ subtitle }}
      </p>
    </div>
    <div class="flex flex-row space-x-[10px] bg-gray-100 items-center justify-center px-[10px] rounded-[10px]">
      <p class="text-[#16151C] dark:text-white text-sm  font-semibold">
        {{ btnText }}
      </p>
      <ChevronDownIcon class="h-5" />
    </div>
  </div>
</template>
