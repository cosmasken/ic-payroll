<template>
  <div class="rounded-lg py-2 px-4 shadow-sm bg-[#fff]">
    <div class="flex flex-row justify-evenly space-x-1">
      <!--p class="text-base font-semibold" :style="{ color: props.headercolor }">
          {{ props.header }}
        </p-->

      <div class="flex-col border-r border-gray-300 w-1/3">
        <p class="text-xs font-normal text-gray-600">
          {{ props.presentheader }}
        </p>
        <p class="font-semibold text-2xl text-black">
          {{ props.present }}
        </p>
      </div>
      <div class="flex-col border-r border-gray-300 w-1/3">
        <p class="text-xs font-normal text-gray-600">{{ props.leaveheader }}</p>
        <p class="font-semibold text-2xl text-black">
          {{ props.leave }}
        </p>
      </div>
      <div class="flex-col border-gray-300 w-1/3">
        <p class="text-xs font-normal text-gray-600">
          {{ props.absentheader }}
        </p>
        <p class="font-semibold text-2xl text-black">
          {{ props.absent }}
        </p>
      </div>
    </div>
  </div>
</template>
<script setup>
const props = defineProps([
  "presentheader",
  "leaveheader",
  "absentheader",
  "leave",
  "present",
  "absent",
]);
</script>
