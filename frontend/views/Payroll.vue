<script setup>
import TableComponent from '../components/TableComponent.vue'
import Searchbar from '../components/Searchbar.vue'
import Header from '../components/Header.vue'
</script>
<template>
  <div class="p-5">
    <div class="bg-white dark:bg-transparent">
      <Header text="Export" />
      <!-- table section -->
      <TableComponent />
      <!-- table section -->
    </div>
  </div>
</template>
