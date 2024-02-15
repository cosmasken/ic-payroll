<script setup>
import TableComponent from "../components/TableComponent.vue";
import Searchbar from "../components/Searchbar.vue";
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../store/auth";
const authStore = useAuthStore();

let isRunning = ref(false);
let response = ref("");
// watchEffect(async () => {
//   const res = await authStore.whoamiActor?.runpayroll([{
//       id: 500,
//       creator: "Cosmas",
//       destination:"frmzq-vsyar-77di6-mjado-ej6nq-xlxox-o32rv-p7s76-2nkcs-d3tcu-cae",
//       created_at: 1400,
//       amount: 500,
//       successful: true,
      
//     }]);
//     response = await res;

//     console.log(response);
  
// });5lnja-ztbzy-c4kyn-telka-nwtuk-5h2jn-fcesl-tovut-2ytto-5stlw-pae
const runPayroll = async () => {
  try {
    isRunning.value = true;
    console.log("wtf");
    const res = await authStore.whoamiActor?.runpayroll([
      {
      id: 500,
      creator: "Cosmas",
      destination:"frmzq-vsyar-77di6-mjado-ej6nq-xlxox-o32rv-p7s76-2nkcs-d3tcu-cae",
      created_at: 1400,
      amount: 1500,
      successful: true,
      
    },{
      id: 2500,
      creator: "Cosmas",
      destination:"5lnja-ztbzy-c4kyn-telka-nwtuk-5h2jn-fcesl-tovut-2ytto-5stlw-pae",
      created_at: 1400,
      amount: 1500,
      successful: true,
      
    }
  ]);
    response = await res;

    console.log(response);
  } catch (e) {
    console.log("Error fetching data");
  } finally {
    isRunning.value = false;
  }
};
</script>
<template>
  <div class="p-5">
    <div class="bg-white dark:bg-transparent">
      <div class="flex flex-row justify-between">
        <Searchbar />
        <div class="flex flex-row space-x-5">
          <div
            @click="runPayroll"
            class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
          >
            <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
            <p class="text-base font-light text-white">Run Payroll</p>
          </div>
          <div
            class="rounded-[10px] cursor-pointer flex flex-row p-5 bg-[#7152F3] h-[50px] items-center space-x-[10px]"
          >
            <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
            <p class="text-base font-light text-white">Single Payment</p>
          </div>
        </div>
      </div>

      <!-- table section -->
      <TableComponent />
      <!-- table section -->
    </div>
  </div>
</template>
