<template>
  <form>
    <div class=" p-5">
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
        <AssetUpload >Upload Appointment Letter</AssetUpload>
        <AssetUpload >Upload Salary Slips</AssetUpload>
        <AssetUpload >Upload Reliving Letter</AssetUpload>
        <AssetUpload >Upload Experience Letter</AssetUpload>
      </div>
    </div>

    <div class=" flex items-center justify-end gap-x-6 px-5">
      <button
        class="text-sm font-semibold leading-6 text-gray-900 dark:text-white"
        type="button"
      >
        Cancel
      </button>
      <button
        class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        type="button"
        @click="addData()"
      >
        Submit
      </button>
    </div>
  </form>
</template>
<script setup>
import { ref } from "vue"
import { useAuthStore } from "../store/auth"
import AssetUpload from "../components/AssetUpload.vue"

const isLoading = ref(false)
const authStore = useAuthStore()
const registrationData = {
  // first_name: "",
  // last_name: "",
  // email: "",
  // phone_number: "",
  wallet_address: "",
}
const addData = async () => {
  isLoading.value = true
  authStore.updateRegistrationData(registrationData)
  // const firstname = authStore.registrationData.first_name;
  // const lastname = authStore.registrationData.last_name;
  // const email = authStore.registrationData.email;
  // const phone = authStore.registrationData.phone_number;
  const address = authStore.registrationData.wallet_address

  console.log(address)

  try {
    const response = authStore.create_employee(
      // firstname,
      // lastname,
      // email,
      // phone,
      address,
    )
    await new Promise((resolve) => setTimeout(resolve, 5000))
  } catch (error) {
    console.error("Error submitting data:", error)
  } finally {
    isLoading.value = false
    console.error("Successful:")
    router.push("/home/contacts")
  }
}
</script>