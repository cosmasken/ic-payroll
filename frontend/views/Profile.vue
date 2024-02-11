<template>
  <div>
    <p>Name:</p>
    <p>Email:</p>
    <p>Name:</p>
    <p>Phone:</p>
    <button @click="proceed" class="btn btn-primary">Proceed</button>
  </div>
</template>

<script setup>
import router from "../router";

const proceed = () => {
  router.push("/home/dashboard");
};
</script>

<style scoped>
/* Add your styles here */
</style>
