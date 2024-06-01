<template>
  <div class="flex flex-col bg-[#b6babd] p-5 rounded-md">
    <p>
      <span class="font-bold text-md text-gray-800">{{ header }}</span>
    </p>
    <p>
      <span class="font-bold text-lg text-gray-800">
        {{ text }}
      </span>
    </p>
  </div>
</template>
<script setup>
defineProps({
  header: String,
  text: String,
});
</script>
