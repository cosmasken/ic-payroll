<template>
  <!--div class="mx-auto w-full">
    <h2>You are authenticated!</h2>
    <p>
      {{  response }}
    </p>
    <p @click="whoamiCall">To see how a canister views you, click this button!</p>
   
    <div v-if="companyStore.isInitialized == false">
<p class="font-light text-grey text-base dark:text-white">Setup your company by importing your data</p>
<UserType/>
    </div>
    <div v-else>
      <button  class="text-sm tex-black ring-1 ring-black">Proceed</button>
    </div>
    
    <button
      class="border border-gray-600 flex p-2 mt-4 mr-4 mb-4 ml-auto text-sm w-auto"
      @click="async () => await authStore.logout()"
    >
      log out
    </button>
  </div-->

  <div class="flex min-h-full flex-1">
    <div class="mx-auto flex flex-col w-full max-w-screen lg:w-96 items-center">
        <img
            class="h-10 w-auto"
            src="../assets/dfinity.svg"
            alt="Dfinity"
          />
        <div >
          
          <h2
            class="mt-8 text-2xl text-center font-bold leading-9 tracking-tight text-gray-900"
          >
            You are authenticated!
          </h2>
          
          <button class="border border-gray-300 rounded-[10px] p-5">
            principal : {{  response }}<br>
            ckbtc balance  :  {{  balance }}<br>
           
          </button>

          

        <UserType/>

        <div 
          @click="gotoDashboard()"
          class="mt-6 grid grid-cols-1 gap-4">
            <a
              href="#"
              class="flex w-full items-center justify-center gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
            >
              <img
                src="../assets/dfinity.svg"
                alt="Dfinity"
                class="h-5 w-5"
              />
              <span class="text-sm font-semibold leading-6"
                >Proceed</span
              >
            </a>
          </div>
        </div>
       
        <div class="mt-10">
          <div 
          @click="authStore.logout()"
          class="mt-6 grid grid-cols-1 gap-4">
            <a
              href="#"
              class="flex w-full items-center justify-center gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
            >
              <img
                src="../assets/dfinity.svg"
                alt="Dfinity"
                class="h-5 w-5"
              />
              <span class="text-sm font-semibold leading-6"
                >Logout</span
              >
            </a>
          </div>
        </div>
      </div>
  </div>
</template>

<script setup>
import { ref , watchEffect } from "vue"
import { useAuthStore } from "../store/auth"
import { useCompanyStore } from "../store/company"
import UserType from "./onboarding/UserType.vue"

import router from "../router"

const companyStore = useCompanyStore()

const authStore = useAuthStore()
let response = ref("")

const balance = ref("")
const paymentres = ref("")



watchEffect(async () => {
  const res = await  authStore.whoamiActor?.whoami()
  response.value =  await res
})

watchEffect(async () => {
  const res = await  authStore.whoamiActor?.getBalance()
  balance.value =  await res
})


watchEffect(async () => {
  const res = await authStore.whoamiActor?.makeTransfer('inhle-3bt2j-k3bn6-kp5my-33r3q-lpe4j-s4c57-fpzvm-up5rx-smpre-5qe',500)
  paymentres.value =  await res
})

function gotoDashboard() {
  router.push({ name: 'Dashboard' })
}

// -> logs 0

const storeSetup = companyStore.isInitialized;
function sendMulla() {
  authStore.whoamiActor?.makeTransfer('inhle-3bt2j-k3bn6-kp5my-33r3q-lpe4j-s4c57-fpzvm-up5rx-smpre-5qe',500).then((res) => {
    response.value = res
  })
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>

</style>
