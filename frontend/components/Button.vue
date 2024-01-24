<script setup>
defineProps({
  title: String,
});
</script>

<template>
  <div class="rounded-[10px] inline-flex flex-row p-5 bg-[#7152F3]">
    <!--img :src="iconUrl" alt="" class="w-6 h-6"/-->
    <p class="text-base font-light dark:text-white text-textcolor">
      {{ title }}
    </p>
  </div>
</template>

<style scoped></style>
