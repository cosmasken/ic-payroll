<script setup>
import JobCardVue from "../components/JobCard.vue";
import Searchbar from "../components/Searchbar.vue";
</script>
<template>
  <div class="flex flex-col space-y-[30px] p-5">
    <div class="flex flex-row justify-between">
      <Searchbar />
      <div
        class="rounded-[10px] inline-flex flex-row p-5 bg-[#7152F3] h-[50px] space-x-[10px] items-center"
      >
        <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
        <p class="text-base font-light text-white">Add New Job</p>
      </div>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-3 gap-5">
      <!-- Active jobs-->
      <div
        class="flex flex-col space-y-4 rounded-[10px] border border-[#A2A1A833] p-4"
      >
        <div class="flex flex-row space-x-2 items-center">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="10"
            height="10"
            viewBox="0 0 10 10"
            fill="none"
          >
            <circle cx="5" cy="5" r="5" fill="#EFBE12" />
          </svg>
          <p
            class="text-[14px] leading-[22px] text-[#16151C] dark:text-white font-semibold"
          >
            Active Class
          </p>
        </div>

        <div class="grid grid-cols-1 gap-4">
          <JobCardVue />
          <JobCardVue />
          <JobCardVue />
          <JobCardVue />
        </div>
      </div>
      <!-- InAcive jobs-->
      <div
        class="flex flex-col space-y-4 rounded-[10px] border border-[#A2A1A833] p-4"
      >
        <div class="flex flex-row space-x-2 items-center">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="10"
            height="10"
            viewBox="0 0 10 10"
            fill="none"
          >
            <circle cx="5" cy="5" r="5" fill="#EFBE12" />
          </svg>
          <p
            class="text-[14px] leading-[22px] text-[#16151C] dark:text-white font-semibold"
          >
            Active Class
          </p>
        </div>

        <div class="grid grid-cols-1 gap-4">
          <JobCardVue />
          <JobCardVue />
        </div>
      </div>
      <!-- Complete jobs-->
      <div
        class="flex flex-col space-y-4 rounded-[10px] border border-[#A2A1A833] p-4"
      >
        <div class="flex flex-row space-x-2 items-center">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="10"
            height="10"
            viewBox="0 0 10 10"
            fill="none"
          >
            <circle cx="5" cy="5" r="5" fill="#EFBE12" />
          </svg>
          <p
            class="text-[14px] leading-[22px] text-[#16151C] dark:text-white font-semibold"
          >
            Active Class
          </p>
        </div>

        <div class="grid grid-cols-1 gap-4">
          <JobCardVue />
          <JobCardVue />
        </div>
      </div>
    </div>
  </div>
</template>
