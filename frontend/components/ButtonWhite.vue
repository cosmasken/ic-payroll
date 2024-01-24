<script setup>
import { ref } from "vue";
defineProps({
  title: String,
  iconUrl: String,
  bgcolor: String,
});
</script>

<template>
  <div
    class="rounded-[10px] inline-flex flex-row p-5 bg-transparent border border-[#A2A1A833]"
  >
    <!--img :src="iconUrl" alt="" class="w-6 h-6"/-->
    <p class="text-base font-light dark:text-white text-textcolor">
      {{ title }}
    </p>
  </div>
</template>

<style scoped></style>
