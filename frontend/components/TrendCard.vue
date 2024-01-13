<script setup>
import { ref } from "vue"

defineProps({
  msg: String,
})

const count = ref(0)
</script>

<template>
  <div
    class="flex flex-col border border-[#A2A1A833] rounded-[10px] divide-y divide-[#A2A1A833]"
  >
    <div class="px-4 pt-4 pb-[10px]">
      <div class="flex flex-row">
        <img src="../assets/totalemp.png" alt="" class="w-6 h-6" />
        <p
          class="text-[#16151C] dark:text-white text-sm leading-[22px] font-light"
        >
          Total Employee
        </p>
      </div>
      <div class="flex flex-row justify-between items-center">
        <p
          class="text-[#16151C] dark:text-white text-[30px] leading-10 font-semibold"
        >
          560
        </p>
        <div
          class="flex flex-row space-x-[10px] items-center bg-[#30BE821A] p-[5px] rounded-[5px]"
        >
          <img src="../assets/up-arrow.png" alt="" class="w-6 h-6" />
          <p class="text-[#30BE82] text-[11px] leading-[16px] font-light">12</p>
        </div>
      </div>
    </div>
    <div class="px-4 py-[10px]">
      <p class="text-[#A2A1A8] font-light text-xs leading-[18px]">
        Update: July 16, 2023
      </p>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
