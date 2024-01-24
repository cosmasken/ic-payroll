<script setup>
import { ref } from "vue";

defineProps({
  name: String,
  role: String,
});

const count = ref(0);
</script>

<template>
  <div class="flex flex-row justify-between items-center cursor-pointer">
    <div class="flex flex-row items-center space-x-[10px]">
      <div>
        <img src="../assets/dp.png" class="h-10 w-10 rounded-full" />
      </div>
      <div class="flex flex-col">
        <p class="font-light text-base text-[#16151C] dark:text-white">
          {{ name }}
        </p>
        <p class="font-light text-xs leading-[18px] text-[#A2A1A8]">
          {{ role }}
        </p>
      </div>
    </div>

    <img src="../assets/direction-right.png" class="h-6 w-6" />
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
