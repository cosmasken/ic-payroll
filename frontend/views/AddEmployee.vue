<template>
  <div>
    <div v-if="isLoading === true">
      <div class="flex justify-center items-center h-screen">
        <div
          class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900"
        ></div>
      </div>
    </div>
    <div v-else>
      <Navbar/>
      <form>
        <div class=" p-5">
          <div>
            <!--h2
              class="text-base font-semibold leading-7 text-gray-900 dark:text-white"
            >
              Principal
            </h2>
            <p class="mt-1 text-sm leading-6 text-gray-600 dark:text-white">
              Add the user principal
            </p-->
         

            <div class=" grid grid-cols-1 gap-x-6 sm:grid-cols-6">
            
            
              
              <div class="col-span-full">
                <label
                  for="wallet-address"
                  class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                  >Wallet address</label
                >
                <div >
                  <input
                    v-model="registrationData.wallet_address"
                    type="text"
                    name="wallet-address"
                    id="wallet-address"
                    autocomplete="wallet-address"
                    class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                  />
                </div>
              </div>

              <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Employee Type</label
               >
               <div >
                 <input
                   v-model="registrationData.emp_type"
                   type="text"
                   name="employee-type"
                   id="employee-type"
                   autocomplete="employee-type"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
               
              </div>
              <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Access Type</label
               >
               <div >
                 <input
                   v-model="registrationData.access_type"
                   type="text"
                   name="access-type"
                   id="access-type"
                   autocomplete="access-type"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
               
              </div>

        
            </div>
          </div>
        </div>

        <div class=" flex items-center justify-end gap-x-6 px-5">
          <button
            type="button"
            class="text-sm font-semibold leading-6 text-gray-900 dark:text-white"
          >
            Cancel
          </button>
          <button
            type="button"
            @click="addData()"
            class="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          >
            Submit
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useAuthStore } from "../store/auth";
import router from "../router/";
import Navbar from "../components/Navbar.vue";
const isLoading = ref(false);
const authStore = useAuthStore();

//get currEnt time to int
const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};

const registrationData = {
  wallet_address: "",
  emp_type: "",
  access_type: "",
};
const addData = async () => {
  isLoading.value = true;
  authStore.updateRegistrationData(registrationData);
  const address = authStore.registrationData.wallet_address;
  const emp_type = authStore.registrationData.emp_type;
  const access_type = authStore.registrationData.access_type;
  try {
    const response = authStore.create_employee(
      address,
      emp_type,
      access_type
    );
    console.log("main"+response)
    await new Promise((resolve) => setTimeout(resolve, 1500));
  } catch (error) {
    console.error("Error submitting data:", error);
  } finally {
    isLoading.value = false;
    console.error("Successful:");
    
    router.push("/home/all-employees");
  }
};
</script>
