<script setup>
import { ref } from "vue"
const tabs = [
  { name: "Male", current: false },
  { name: "Female", current: false },
]

defineProps({
  tabs: Array,
})
</script>
<template>
  <div>
    <select
      v-model="selectedTab"
      id="tabs"
      name="tabs"
      class="block w-full rounded-[10px] border border-[#A2A1A833]/10 py-4 pl-4 pr-5 text-textcolor dark:text-darktextcolor ring-1 ring-inset ring-[#A2A1A8CC]/80 placeholder:text-[#A2A1A8CC]/80 focus:ring-2 focus:ring-inset focus:ring-[#A2A1A8CC]/80 sm:text-base sm:leading-6 font-light"
    >
      <option v-for="tab in tabs" :key="tab.name" :selected="tab.current">
        {{ tab.name }}
      </option>
    </select>
  </div>
</template>
