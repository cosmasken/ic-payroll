<script setup>
import { useAuthStore } from "../../store/auth";
const authStore = useAuthStore();

const init = () => {
  authStore.init();
};

const login = () => {
  init();
  console.log("login");
  authStore.login();
};

const requestAccounts = () => {
  init();
  authStore.requestAccounts();
};
</script>
<template>
  <div class="flex min-h-full">
    <div
      class="flex flex-col justify-center px-4 py-12 sm:px-6 lg:flex-none lg:px-20 xl:px-24"
    >
      <div class="mx-auto flex flex-col w-full max-w-sm lg:w-96 items-center">
        <img class="h-10 w-auto" src="../../assets/dfinity.svg" alt="Dfinity" />
        <div>
          <h2
            class="mt-8 text-2xl font-bold leading-9 tracking-tight text-gray-900"
          >
            Sign in to your account
          </h2>
        </div>
        <div class="flex flex-col">
          <div class="mt-10">
            <div @click="login()" class="mt-6 grid grid-cols-1 gap-4">
              <a
                href="#"
                class="flex w-full items-center justify-between gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-5"
                />
                <span class="text-sm font-semibold leading-6"
                  >Internet Identity</span
                >
              </a>
            </div>
          </div>

          <div class="">
            <div @click="requestAccounts()" class="mt-6 grid grid-cols-1 gap-4">
              <a
                href="#"
                class="flex w-full items-center justify-left gap-3 rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus-visible:ring-transparent"
              >
                <img
                  src="../../assets/dfinity.svg"
                  alt="Google"
                  class="h-5 w-5"
                />
                <span class="text-sm font-semibold leading-6">Metamask</span>
              </a>
            </div>
          </div>
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
