<template>
  <div
    class="rounded-lg py-2 px-4 shadow-sm"
    :style="{ backgroundColor: props.bgcolor }"
  >
    <div class="flex flex-col space-y-2">
      <p class="text-base font-semibold" :style="{ color: props.headercolor }">
        {{ props.header }}
      </p>

      <div class="flex basis-1/2 flex-col border-r border-gray-300 shrink-0">
        <p class="text-xs font-normal">{{ props.currency1 }}</p>
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
  "currency1",
  "currency2",
  "bgcolor",
  "headercolor",
  "currency1color",
  "currency2color",
  "balance",
]);
</script>
