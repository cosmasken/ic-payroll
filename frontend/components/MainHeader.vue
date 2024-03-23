<script setup>
import { ref } from "vue";
import Search from "./Searchbar.vue";

defineProps({
  text: String,
});

const count = ref(0);
</script>

<template>
  <div class="flex flex-row justify-between py-4">
    <div class="flex flex-col ">
      <p class="text-dark-500 dark:text-white-500 text-[20px] font-semibold leading-[30px]">
        All Departments
      </p>
      <p class="text-gray-500 text-sm leading-[22px]">
        All Departments Information
      </p>
    </div>


    <div class="flex flex-row  justify-start items-center  border border-gray-500 rounded-[10px] p-1">
      <div class=" h-full w-10 overflow-hidden rounded-[10px]">
    <img src="../assets/photo.png" class="h-full w-full" />
  </div>

  <div class="flex space-x-2 flex-row items-center justify-between rounded px-3">
    <div>
      <p class="-mb-1 text-left text-[9px] font-medium text-gray-600 group-hover:text-white">INDIVIDUAL ACCOUNT</p>
      <p class="text-left text-[0.9rem] font-semibold text-gray-900 group-hover:text-gray-400">Ada Robin</p>
    </div>
    <div class=" rounded-md border p-1.5 hover:bg-gray-100">
      <svg class="h-3 w-3 rotate-0 rotate-180 transform transform text-gray-500"
       xmlns="http://www.w3.org/2000/svg" width="10" height="7" viewBox="0 0 10 7"
        fill="none"><path fill-rule="evenodd" clip-rule="evenodd"
         d="M0.293081 0.792971C0.480608 0.6055 0.734916 0.500184 1.00008 0.500184C1.26524 0.500184 1.51955 0.6055 1.70708 0.79297L5.00008 4.08597L8.29308 0.79297C8.48168 0.610812 8.73428 0.510018 8.99648 0.512296C9.25868 0.514574 9.50949 0.619743 9.6949 0.805151C9.88031 0.990559 9.98548 1.24137 9.98775 1.50357C9.99003 1.76577 9.88924 2.01837 9.70708 2.20697L5.70708 6.20697C5.51955 6.39444 5.26525 6.49976 5.00008 6.49976C4.73492 6.49976 4.48061 6.39444 4.29308 6.20697L0.293081 2.20697C0.10561 2.01944 0.000294271 1.76513 0.000294248 1.49997C0.000294225 1.23481 0.105609 0.980498 0.293081 0.792971Z" fill="#B2B9C0"></path></svg>
    </div>
  </div>

</div>



  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
