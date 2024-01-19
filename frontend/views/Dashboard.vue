<script setup>
import TrendCard from "../components/TrendCard.vue"
import {ref ,watchEffect} from "vue"
import OverviewCard from "../components/OverviewCard.vue"
import { useAuthStore } from "../store/auth"
const authStore = useAuthStore()
let response = ref(0)
// watchEffect(async () => {
//   const res = await authStore.whoamiActor?.getNumberOfFreelancers()
//   response.value = await res
// })

</script>
<template>
<div class="p-5 flex flex-col gap-5">
  <div class="grid grid-cols-1 sm:grid-cols-2  gap-4">
          <OverviewCard
            header="Total Spent"
            fiat="Fiat"
            currency1="CKBTC"
            currency2="CKETH"
            headercolor="#36B293"
            bgcolor="#EDFFFB"
            fiatColor="#36B293"
            currency1color="#36B293"
            currency2color="#36B293"
          />
          <OverviewCard
            header="Outstanding Amount"
            fiat="Fiat"
            currency1="CKBTC"
            currency2="CKETH"
            headercolor="#4C98FF"
            bgcolor="#E0ECFE"
            fiatColor="#4C98FF"
            currency1color="#4C98FF"
            currency2color="#4C98FF"
          />
          <OverviewCard
            header="Upcoming Payments"
            fiat="Fiat"
            currency1="CKBTC"
            currency2="CKETH"
            headercolor="#1F2937"
            bgcolor="#FFF"
            fiatColor="#36B293"
            currency1color="#4C98FF"
            currency2color="#F6BB22"
          />
          <OverviewCard
            header="Transactions"
            fiat="Fiat"
            currency1="CKBTC"
            currency2="CKETH"
            headercolor="#1F2937"
            bgcolor="#FFF"
            fiatColor="#36B293"
            currency1color="#36B293"
            currency2color="#F6BB22"
          />
        </div>
 
  <div class="flex flex-row ">
    <div class="w-full">
      <div class="flex flex-col w-full">
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
          <div
    class="flex flex-col border border-[#A2A1A833] rounded-[10px] divide-y divide-[#A2A1A833]"
  >
    <div class="px-4 pt-4 pb-[10px]">
      <div class="flex flex-row">
        <img src="../assets/totalemp.png" alt="" class="w-6 h-6" />
        <p
          class="text-[#16151C] dark:text-white text-sm leading-[22px] font-light"
        >
         Employees
        </p>
      </div>
      <div class="flex flex-row justify-between items-center">
        <p
          class="text-[#16151C] dark:text-white text-[30px] leading-10 font-semibold"
        >
          {{response}}
        </p>
        <div
          class="flex flex-row space-x-[10px] items-center bg-[#30BE821A] p-[5px] rounded-[5px]"
        >
          <img src="../assets/up-arrow.png" alt="" class="w-6 h-6" />
          <p class="text-[#30BE82] text-[11px] leading-[16px] font-light">12</p>
        </div>
      </div>
    </div>
    <div class="px-4 py-[10px]">
      <p class="text-[#A2A1A8] font-light text-xs leading-[18px]">
        Update: July 16, 2023
      </p>
    </div>
  </div>
        
        </div>
      </div>
    </div>
   
  </div>

  </div>
</template>
