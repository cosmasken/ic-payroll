<script setup>
<<<<<<< HEAD
import AuthDropDown  from "./AuthDropDown.vue";
import { useAuthStore } from "../../store/auth"
const authStore = useAuthStore()
=======
import { useAuthStore } from "../../store/auth";
import { useEthStore } from "../../store/eth";
import { ref } from "vue";
const authStore = useAuthStore();

const ethStore = useEthStore();

const texted = "vwewegwegwegewe"
//import { ConnectButton, ConnectDialog, useConnect } from "@connect2ic/vue"
>>>>>>> workingpoint
</script>
<template>
  <div class="flex min-h-full flex-1">
    <div
      class="flex flex-1 flex-col justify-center px-4 py-12 sm:px-6 lg:flex-none lg:px-20 xl:px-24 space-x-5"
    >
<<<<<<< HEAD
      <div class="mx-auto flex flex-col w-full max-w-sm lg:w-96 items-center space-y-5">
        <img
          class="h-10 w-auto"
          src="../../assets/dfinity.svg"
          alt="Dfinity"
        />
=======
      <div class="mx-auto flex flex-col w-full max-w-sm lg:w-96 items-center">
        <img class="h-10 w-auto" src="../../assets/dfinity.svg" alt="Dfinity" />
>>>>>>> workingpoint
        <div>
          <h2
            class="mt-8 text-2xl font-bold leading-9 tracking-tight text-gray-900"
          >
            Sign in to your account
          </h2>
        </div>
        <div class="flex flex-col w-full">
          <div class="margin-5 flex   justify-center">
            <AuthDropDown/>
            </div>
          
          <div v-if="authStore.authType === 'internet-identity'">
            <div @click="authStore.login()" class=" justify-center mt-6 grid grid-cols-1 gap-4">
              <a
                href="#"
                class="flex w-full items-center justify-between gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-full"
                />
                <span class="text-sm font-semibold leading-6"
                  >Internet Identity</span
                >
              </a>
            </div>
          </div>
<<<<<<< HEAD
          <div v-if="authStore.authType === 'connect2ic'">
            <div class=" justify-center mt-6 grid grid-cols-1 gap-4">
=======
          <!--div class="">
            <div class="mt-6 grid grid-cols-1 gap-4">
>>>>>>> workingpoint
              <a
                href="#"
                class="flex w-full items-center justify-left gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-full"
                />
                <span class="text-sm font-semibold leading-6">Connect2IC</span>
                <ConnectButton />
                <ConnectDialog dark="{false}" />
              </a>
            </div>
<<<<<<< HEAD
          </div>
          <div v-if="authStore.authType === 'siwe'">
            <div class=" justify-center mt-6 grid grid-cols-1 gap-4"  >
              <a
                href="#"
                class="flex w-full items-center justify-left gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-full"
                />
                <span class="text-sm font-semibold leading-6" @click="authStore.connect()">Ethereum {{ address }}</span>
                <span class="text-sm font-semibold leading-6" > {{ principal }}</span>
                <button @click="authStore.switchAccount()" class="text-sm font-semibold leading-6">Switch</button>
              </a>
            </div>
          </div>
          <!--div v-if="isConnected">
            <div class="mt-6 grid grid-cols-1 gap-4"  >
=======
          </div-->
          <!--div class="">
            <div  class="mt-6 grid grid-cols-1 gap-4">
>>>>>>> workingpoint
              <a
                href="#"
                class="flex w-full items-center justify-left gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-5"
                />
                <span class="text-sm font-semibold leading-6" @click="signInWithEthereum()">SIWE</span>
              </a>
            </div>
          </div-->
        </div>
      </div>
    </div>
    <div class="relative hidden w-0 flex-1 lg:block h-screen">
      <img
        class="absolute inset-0 h-full w-full object-cover"
        src="../../assets/hero.png"
        alt=""
      />
    </div>
  </div>
</template>
