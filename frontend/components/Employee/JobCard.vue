<script setup>
import { ref } from "vue";

defineProps({
  designation: String,
  department: String,
  location: String,
  type: String,
  remote: String,
  salary: String,
});

const count = ref(0);
</script>

<template>
  <div class="flex flex-col bg-[#A2A1A80D] rounded-[10px] p-4">
    <div class="flex flex-row pb-[14px]">
      <div class="p-[10px]">
        <img src="../assets/briefcase 04.png" class="h-6 w-6" />
      </div>
      <div class="flex flex-col">
        <p class="text-base text-[#16151C] dark:text-white font-semibold">
          UI/UX Designer
        </p>
        <p class="text-[#A2A1A8] font-light text-[14px] leading-[22px]">
          Design
        </p>
      </div>
    </div>
    <div class="flex flex-row space-x-[10px] pb-[21px]">
      <button
        class="rounded-[5px] bg-[#7152F3] text-[#FFFFFF] p-[10px] text-xs leading-[18px] font-light"
      >
        Design
      </button>
      <button
        class="rounded-[5px] bg-[#7152F3] text-[#FFFFFF] p-[10px] text-xs leading-[18px] font-light"
      >
        FullTime
      </button>
      <button
        class="rounded-[5px] bg-[#7152F3] text-[#FFFFFF] p-[10px] text-xs leading-[18px] font-light"
      >
        Remote
      </button>
    </div>
    <div class="flex flex-row justify-between">
      <div class="flex flex-row items-center">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
        >
          <circle cx="12" cy="11" r="3" stroke="#16151C" stroke-width="1.5" />
          <path
            d="M21 10.8889C21 15.7981 15.375 22 12 22C8.625 22 3 15.7981 3 10.8889C3 5.97969 7.02944 2 12 2C16.9706 2 21 5.97969 21 10.8889Z"
            stroke="#16151C"
            stroke-width="1.5"
          />
        </svg>
        <p
          class="font-light text-[14px] leading-[22px] text-[#16151C] dark:text-white"
        >
          New York, USA
        </p>
      </div>
      <div class="flex flex-row items-center">
        <p
          class="text-[#16151C] dark:text-white text-[18px] leading-[26px] font-semibold"
        >
          1500
        </p>
        <p class="text-[#16151C] dark:text-white text-base font-light">/Hour</p>
      </div>
    </div>
  </div>
</template>
