<template class="font-lexend">
  <WagmiConfig config={wagmiConfig}>
      <RainbowKitProvider
        chains={chains}
        modalSize="compact"
        theme={darkTheme({
          accentColor: "#7b3fe4",
          accentColorForeground: "white",
          borderRadius: "large",
          overlayBlur: "none",
        })}
      >
     <SiweIdentityProvider<_SERVICE>
      canisterId={canisterId}
      idlFactory={idlFactory}
    >
  <main>
 
    <div v-if="isReady">
      <router-view v-if="isAuthenticated" />
      <SignIn v-else />
    </div>
    <div v-else>
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
  </main>
</SiweIdentityProvider<_SERVICE>>
</RainbowKitProvider>
</WagmiConfig>
</template>

<script setup>
import "@rainbow-me/rainbowkit/styles.css";
import { RainbowKitProvider, darkTheme } from "@rainbow-me/rainbowkit";
import { chains, wagmiConfig } from "./wagmi/wagmi.config.ts";
import router from "./router"
import SignIn from "./components/auth/SignIn.vue"
import { storeToRefs } from "pinia"
import { useAuthStore } from "./store/auth"
import {Connect2ICProvider} from "@connect2ic/vue"
import "@connect2ic/core/style.css"
import { SiweIdentityProvider } from 'ic-use-siwe-identity';
import { _SERVICE } from "../src/declarations/ic_siwe_provider/ic_siwe_provider.did"
import { canisterId, idlFactory } from "../src/declarations/ic_siwe_provider/index";

const authStore = useAuthStore()

const authType = authStore.authType;



const { isReady, isAuthenticated, isConfigured } = storeToRefs(authStore)
if (isReady.value === false) {
  authStore.init()
} else {
  router.push("/home/dashboard")
}
</script>
