<script setup>
import { BeakerIcon, ChevronDownIcon } from "@heroicons/vue/24/solid";
defineProps({
  heading: String,
  subtitle: String,
  btnText: String,
  type: String,
  remote: String,
  salary: String,
});
</script>
<template>
  <div class="flex flex-row justify-between">
    <div class="flex flex-col">
      <p>
        {{ heading }}
      </p>
      <p>
        {{ subtitle }}
      </p>
    </div>
    <div class="flex flex-row space-x-[10px]">
      <p>
        {{ btnText }}
      </p>
      <ChevronDownIcon class="h-5" />
    </div>
  </div>
</template>
