<script setup>
import TextInput from "./TextInput.vue"
import Button from "../../components/Button.vue"
import ButtonWhite from "../../components/ButtonWhite.vue"
</script>

<template>
  <div class="flex flex-col space-y-5 py-[30px]">
    <div
      class="flex h-20 w-20 bg-[#A2A1A80D] border border-[#A2A1A833] rounded-[10px] items-center justify-center"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="24"
        height="24"
        viewBox="0 0 24 24"
        fill="none"
      >
        <path
          d="M15 13.5C15 15.1569 13.6569 16.5 12 16.5C10.3431 16.5 9 15.1569 9 13.5C9 11.8431 10.3431 10.5 12 10.5C13.6569 10.5 15 11.8431 15 13.5Z"
          stroke="#16151C"
          stroke-width="1.5"
        />
        <circle cx="12" cy="7" r="1" fill="#16151C" />
        <path
          d="M21 15.5V11.5C21 8.73858 18.7614 6.5 16 6.5H15.874C15.4299 4.77477 13.8638 3.5 12 3.5C10.1362 3.5 8.57006 4.77477 8.12602 6.5H8C5.23858 6.5 3 8.73858 3 11.5V15.5C3 18.2614 5.23858 20.5 8 20.5H16C18.7614 20.5 21 18.2614 21 15.5Z"
          stroke="#16151C"
          stroke-width="1.5"
          stroke-linejoin="round"
        />
      </svg>
    </div>

    <div class="grid grid-cols-1  gap-5">
      <TextInput label="FullName" placeholder="FullName" />
      <TextInput label="Email" placeholder="Email" />
      <TextInput label="Phone" placeholder="Phone" />
      <TextInput label="Address" placeholder="Address" />
      <TextInput label="City" placeholder="City" />
    </div>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
      <TextInput label="First Name" placeholder="First Name" />
      <Marital />
      <Gender />
      <Nationality />
    </div>
   
  
    <div class="flex flex-row justify-end space-x-5 pt-[10px]">
      <Button title="Next" />
      <ButtonWhite title="Cancel" />
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
