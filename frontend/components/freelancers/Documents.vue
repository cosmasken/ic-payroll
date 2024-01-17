<script setup>
import { ref } from "vue"
import AssetUpload from "../AssetUpload.vue"

defineProps({
  msg: String,
})

const tabs = [
  {
    name: "Personal Information",
    href: "/home/add-employee/personal-information",
    current: false,
  },
  {
    name: "Professional Information",
    href: "/home/add-employee/professional-information",
    current: false,
  },
  { name: "Documents", href: "/home/add-employee/documents", current: true },
  { name: "Account Access", href: "/account-access", current: false },
]

const changeTab = (index) => {
  tabs.forEach((tab, i) => {
    tab.current = i === index
  })
}

const count = ref(0)
</script>

<template>
  <div class="flex flex-col space-y-5 py-[30px]">
    <div class="grid grid-cols-1 sm:grid-cols-2">
      <AssetUpload />
      <AssetUpload />
      <AssetUpload />
      <AssetUpload />
    </div>
    <div class="flex flex-row justify-end space-x-5 pt-[10px]">
      <Button title="Next" />
      <ButtonWhite title="Cancel" />
    </div>
  </div>
</template>

<style scoped></style>
