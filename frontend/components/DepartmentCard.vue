<script setup>
import { ref } from "vue"
import EmployeeDepartmentCard from "./EmployeeDepartmentCard.vue"
import router from "../router"

defineProps({
  msg: String,
})

const count = ref(0)
const gotoViewDepartment = () => {
  router.push("/view-department")
}
</script>

<template>
  <div
    class="border divide-y divide-[#A2A1A833] border-[#A2A1A833] rounded-[10px] p-5 flex flex-col"
  >
    <div class="flex flex-row justify-between items-center pb-[10px]">
      <div class="flex flex-col">
        <p
          class="font-semibold text-xl leading-[30px] text-[#16151C] dark:text-white"
        >
          Design Department
        </p>
        <p class="font-light text-base leading-[22px] text-[#A2A1A8]">
          20 Members
        </p>
      </div>
      <p
        @click="gotoViewDepartment()"
        class="font-light text-base text-[#7152F3] cursor-pointer hover:text-lg"
      >
        View All
      </p>
    </div>

    <div class="flex flex-col pt-5 space-y-4">
      <EmployeeDepartmentCard name="Dianne Russ" role="Engineering head" />
      <EmployeeDepartmentCard name="Dianne Russ" role="Engineering head" />
      <EmployeeDepartmentCard name="Dianne Russ" role="Engineering head" />
      <EmployeeDepartmentCard name="Dianne Russ" role="Engineering head" />
      <EmployeeDepartmentCard name="Dianne Russ" role="Engineering head" />
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
