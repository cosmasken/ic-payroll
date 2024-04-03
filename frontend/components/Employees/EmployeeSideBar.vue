<script setup lang="ts">
import { storeToRefs } from 'pinia';
import { useMenuStore } from '../../store/menu';
import MenuItem from './MenuItem.vue';

const menuStore = useMenuStore();
const { menus } = storeToRefs(menuStore);
</script>

<template>
  <div
    class="flex items-start p-6 pt-10 gap-4 justify-center md:block w-full md:w-[270px] h-44 xs:h-52 md:h-full md:rounded-xl bg-mobile-sidebar-bg md:bg-desktop-sidebar-bg bg-no-repeat bg-cover bg-center"
  >
    <MenuItem
      v-for="(menu, idx) in menus"
      :key="menu"
      :name="menu"
      :idx="idx + 1"
    />
  </div>
</template>
