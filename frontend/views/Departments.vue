<script setup>
import Searchbar from '../components/Searchbar.vue'
import DepartmentCard from '../components/DepartmentCard.vue'
//
</script>
<template>
  <div class="flex flex-col p-5">
    <div>
      <Searchbar />
    </div>
    <div class="pt-[30px] grid grid-cols-1 md:grid-cols-2 gap-5">
      <DepartmentCard />
      <DepartmentCard />
      <DepartmentCard />
      <DepartmentCard />
    </div>
  </div>
</template>
