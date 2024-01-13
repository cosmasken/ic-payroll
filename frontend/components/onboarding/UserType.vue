<script setup>
import { useCompanyStore } from "../store/company"

const companyStore = useCompanyStore()
</script>
<template>
    <div>
        <h1>Onboarding</h1>
        <p>What type of user are you?</p>
        <button @click="companyStore.setIsInitialized(true)">I'm a company</button>
        <button @click="companyStore.setIsInitialized(false)">I'm a freelancer</button>
    </div>
</template>