<script setup>
import TextInput from "./TextInput.vue"
import Button from "../../components/Button.vue"
import ButtonWhite from "../../components/ButtonWhite.vue"
</script>

<template>
  <div class="flex flex-col space-y-5 py-[30px]">
    <div class="grid grid-cols-1 sm:grid-cols-2">
      <TextInput label="First Name" placeholder="First Name" />
      <TextInput label="First Name" placeholder="First Name" />
      <TextInput label="First Name" placeholder="First Name" />
      <TextInput label="First Name" placeholder="First Name" />
    </div>

    <div class="flex flex-row justify-end space-x-5 pt-[10px]">
      <Button title="Next" />
      <ButtonWhite title="Cancel" />
    </div>
  </div>
</template>

<style scoped></style>
