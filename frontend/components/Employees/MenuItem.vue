<script setup lang="ts">
import { useMenuStore } from '../../store/menu';
import { storeToRefs } from 'pinia';

defineProps<{
  idx: number;
  name: string;
}>();

const menuStore = useMenuStore();
const { currentMenuIdx } = storeToRefs(menuStore);
</script>

<template>
  <div class="flex items-center mb-6 text-sm">
    <div
      class="w-10 h-10 md:w-9 md:h-9 flex items-center justify-center font-bold transition-all border rounded-full"
      :class="
        currentMenuIdx === idx
          ? 'bg-light-blue text-black border-light-blue'
          : 'text-white border-white'
      "
    >
      {{ idx }}
    </div>
    <div class="flex-1 pl-4 uppercase hidden md:block">
      <p class="text-pastel-blue font-thin text-sm leading-5">Step {{ idx }}</p>
      <h1 class="text-white font-bold tracking-wide">
        {{ name }}
      </h1>
    </div>
  </div>
</template>
