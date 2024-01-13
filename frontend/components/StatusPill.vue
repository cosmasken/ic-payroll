<script setup>
defineProps({
  text: String,
  backgroundColor: String,
  onTime: Boolean,
})
</script>
<template>
  <div
    class="px-2 py-[3px] justify-center items-center rounded"
    :class="{ 'bg-earlyBgColor': onTime, 'bg-lateBgColor': !onTime }"
  >
    <p
      :class="{ 'text-earlyTextColor': onTime, 'text-lateTextColor': !onTime }"
    >
      {{ text }}
    </p>
  </div>
</template>
