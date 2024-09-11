<template>
  <div class="rounded-lg py-2 px-4 shadow-sm bg-[#fff] w-full">
    <div class="flex flex-col justify-between">
      <p class="text-base font-semibold text-[#1F2937]">
        {{ props.header }}
      </p>

      <div class="flex basis-1/2 flex-col shrink-0">
        <p
          class="font-semibold text-2xl"
          :style="{ color: props.currency1color }"
        >
          {{ props.balance }}
        </p>
      </div>
    </div>
  </div>
</template>
<script setup>
const props = defineProps([
  "header",
  "fiat",
  "headercolor",
  "currency1color",
  "balance",
]);
</script>
