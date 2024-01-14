<script setup>
import TrendCard from "../components/TrendCard.vue"
import Calendar from "../components/Calendar.vue"
</script>
<template>
  <div class="flex flex-row p-5">
    <div class="w-full">
      <div class="flex flex-col w-full">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
          <TrendCard />
          <TrendCard />
          <TrendCard />
          <TrendCard />
        </div>
      </div>
    </div>
    <div class="w-[414px] rounded-[10px] border border-bordercolor p-5">
      <Calendar />
    </div>
  </div>
</template>
