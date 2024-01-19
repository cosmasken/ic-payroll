<template>
    <div class="p-5 flex flex-col space-y-4">
    <h1 class="text-3xl text-[#16151C] dark:text-white font-semibold">
    Transfer
    </h1>
    
    <div class="flex flex-row w-full justify-between space-x-[10px]">
    
    <div class="w-full space-y-2">
    <label class="text-sm text-[#16151C] dark:text-white font-semibold">
    Amount
    </label>
    <input
    type="text"
    class="w-full h-10 rounded-md border bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
    />
    
    </div>
    
    <div class="w-full space-y-2">
    <label class="text-sm text-[#16151C] dark:text-white font-semibold">
        Transaction Priority
    </label>
    <select
    class="w-full h-10 rounded-md border bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
    >
    <option>End of Day</option>
          <option selected="">Immediately</option>
          <option>Pay Date</option>
    </select>
    
    </div>
    
    
    </div>
    
    
    <div class="space-y-2">
        <label class="text-sm text-[#16151C] dark:text-white font-semibold">
            Address   Paste in or select from Address book
        </label>
        <input
        type="text"
        class="w-full h-10 rounded-md border bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
        />
    </div>
    
    <div class="space-y-2">
        <label class="text-sm text-[#16151C] dark:text-white font-semibold">
           Description (Optional)
        </label>
        <input
        type="text"
        class="w-full h-10 rounded-md border bg-transparent border-[#16151C] dark:border-white dark:bg-[#16151C] dark:text-white"
        />
    </div>
    
    <div>
        <button
        type="button" class="inline-flex w-1/5 items-center gap-x-1.5 justify-between rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
        Send
        <div class="-mr-0.5 h-5 w-5" aria-hidden="true" >
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20" fill="none">
      <path fill-rule="evenodd" clip-rule="evenodd" d="M0 10C0 4.48609 4.48609 0 10 0C15.5143 0 20 4.48609 20 10C20 15.5143 15.5143 20 10 20C4.48609 20 0 15.5143 0 10ZM12.0465 13.7857L15.5243 10.3078C15.5648 10.2674 15.5965 10.2196 15.6187 10.1661C15.6626 10.06 15.6626 9.94 15.6187 9.83391C15.5965 9.78043 15.5648 9.73217 15.5243 9.69217L12.0465 6.21435C11.8765 6.04435 11.6017 6.04435 11.4317 6.21435C11.2617 6.38435 11.2617 6.65913 11.4317 6.82913L14.1678 9.56522H4.78261C4.54261 9.56522 4.34783 9.76 4.34783 10C4.34783 10.24 4.54261 10.4348 4.78261 10.4348H14.1678L11.4317 13.1709C11.2617 13.3409 11.2617 13.6157 11.4317 13.7857C11.5165 13.8704 11.6278 13.913 11.7391 13.913C11.8504 13.913 11.9617 13.8704 12.0465 13.7857Z" fill="white"/>
      <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6377 9.2429H4.24774C3.83478 9.2429 3.5 9.58178 3.5 9.99981C3.5 10.4178 3.83478 10.7567 4.24774 10.7567H13.6375L11.2162 13.2079C10.9243 13.5035 10.9243 13.9828 11.2163 14.2783C11.5083 14.5739 11.9818 14.5739 12.2738 14.2783L16.5 9.99984L12.2745 5.72175C11.9826 5.42613 11.5091 5.42608 11.2171 5.72164C10.925 6.0172 10.925 6.49645 11.217 6.79207L13.6377 9.2429Z" fill="#FA7200"/>
    </svg>
        </div>
      </button>
    </div>
    
    </div>
    </template>
    <script setup>
    import { ref ,watchEffect} from 'vue';
import { useAuthStore } from "../store/auth";
const authStore = useAuthStore();
  let res = ref('')


    </script>