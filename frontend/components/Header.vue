<script setup>
import { ref } from "vue"

defineProps({
  text: String,
})

const count = ref(0)
</script>

<template>
  <div class="flex flex-row justify-between">
    <Searchbar />
    <div class="flex flex-row space-x-5">
      <div
        class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
      >
        <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
        <p class="text-base font-light text-white">
          {{ text }}
        </p>
      </div>
      <div
        class="rounded-[10px] flex flex-row cursor-pointer border border-[#A2A1A833] p-5 h-[50px] items-center space-x-[10px]"
      >
        <img src="../assets/filter.png" alt="" class="w-6 h-6" />
        <p class="text-base font-light dark:text-white text-[#16151C]">
          Filter
        </p>
      </div>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
