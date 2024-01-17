<script setup>
import TableComponent from "../components/TableComponent.vue"
import Searchbar from "../components/Searchbar.vue"
</script>
<template>
  <div class="p-5">
    <div class="bg-white dark:bg-transparent">
      <div class="flex flex-row justify-between">
    <Searchbar />
    <div class="flex flex-row space-x-5">
      <div
     
        class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
      >
        <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
        <p class="text-base font-light text-white">
          Run Payroll
        </p>
      </div>
      <div
     
        class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
      >
        <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
        <p class="text-base font-light text-white">
          Single Payment
        </p>
      </div>
    </div>
  </div>
 
      <!-- table section -->
      <TableComponent />
      <!-- table section -->
    </div>
  </div>
</template>
