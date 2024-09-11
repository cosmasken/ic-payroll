<script setup>
const props = defineProps([
  "name",
  "reason",
  "when",
  "leave",
  "present",
  "absent",
]);
</script>
<template>
  <div class="flex flex-row justify-between">
    <div class="flex flex-row space-x-2">
      <img src="../../assets/avatar.png" class="h-25 w-25" alt="leave" />

      <div class="flex flex-col">
        <p class="text-xs font-normal text-black">
          {{ props.name }}
        </p>
        <p class="text-xs font-normal text-gray-400">
          {{ props.reason }}
        </p>
      </div>
    </div>

    <div class="flex flex-col justify-center">
      <p class="text-xs font-normal text-red-500 text-center">
        {{ props.when }}
      </p>
    </div>
  </div>
</template>
