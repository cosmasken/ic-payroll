<script setup>
import TextInput from "./TextInput.vue";
import Button from "../../components/Button.vue";
import ButtonWhite from "../../components/ButtonWhite.vue";
</script>

<template>
  <div class="flex flex-col space-y-5 py-[30px]">
    <div class="grid grid-cols-1">
      <TextInput label="EmpID" placeholder="FreelancerID" />
      <TextInput label="Designation" placeholder="Designation" />
      <TextInput label="Department" placeholder="Department" />
    </div>

    <div class="flex flex-row justify-end space-x-5 pt-[10px]">
      <Button title="Next" />
      <ButtonWhite title="Cancel" />
    </div>
  </div>
</template>

<style scoped></style>
