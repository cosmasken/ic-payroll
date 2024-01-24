<script setup>
import { ref } from "vue";

defineProps({
  msg: String,
});

const count = ref(0);
</script>

<template>
  <div class="w-full flex flex-row justify-between">
    <div class="flex flex-row space-x-4">
      <div class="rounded-[10px] h-20 w-20">
        <img
          class="h-12 w-12 rounded-full"
          src="./assets/photo.png"
          alt="Photo"
        />
      </div>
      <div class="flex flex-col space-y-2">
        <p
          class="text-[#16151C] dark:text-white font-semibold text-2xl leading-9"
        >
          Brooklyn Simmons
        </p>
        <p class="text-[#16151C] dark:text-white font-light text-base">
          Project Manager
        </p>
        <p class="text-[#16151C] dark:text-white font-light text-base">
          brooklyn@gmail.com
        </p>
      </div>
    </div>
    <div>
      <button class="bg-[#7152F3] text-white text-base">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          fill="none"
        >
          <path
            d="M3 21H21M13.7844 5.31171C13.7844 5.31171 13.7844 6.94634 15.419 8.58096C17.0537 10.2156 18.6883 10.2156 18.6883 10.2156M7.31963 17.9881L10.7523 17.4977C11.2475 17.4269 11.7064 17.1975 12.06 16.8438L20.3229 8.58096C21.2257 7.67818 21.2257 6.21449 20.3229 5.31171L18.6883 3.67708C17.7855 2.77431 16.3218 2.77431 15.419 3.67708L7.15616 11.94C6.80248 12.2936 6.57305 12.7525 6.50231 13.2477L6.01193 16.6804C5.90295 17.4432 6.5568 18.097 7.31963 17.9881Z"
            stroke="white"
            stroke-width="1.5"
            stroke-linecap="round"
          />
        </svg>
        Edit Profile
      </button>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
