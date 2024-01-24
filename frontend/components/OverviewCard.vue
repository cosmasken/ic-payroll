<template>
  <div
    class="rounded-lg py-2 px-4 shadow-sm"
    :style="{ backgroundColor: props.bgcolor }"
  >
    <div class="flex flex-col space-y-2">
      <p class="text-base font-semibold" :style="{ color: props.headercolor }">
        {{ props.header }}
      </p>

      <div class="flex flex-row space-x-2">
        <div class="flex basis-1/2 flex-col border-r border-gray-300 shrink-0">
          <p class="text-xs font-normal">{{ props.currency1 }}</p>
          <p
            class="font-semibold text-2xl"
            :style="{ color: props.currency1color }"
          >
            1.238
          </p>
        </div>
        <div class="flex basis-1/2 flex-col shrink-0">
          <p class="text-xs font-normal">{{ props.currency2 }}</p>
          <p
            class="font-semibold text-2xl"
            :style="{ color: props.currency2color }"
          >
            1.238
          </p>
        </div>
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
  "fiatColor",
  "currency1color",
  "currency2color",
]);
</script>
