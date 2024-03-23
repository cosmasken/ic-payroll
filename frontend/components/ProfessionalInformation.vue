<template>
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

           <div class="flex h-[100px] w-[100px] bg-gray-20% rounded-[10px] items-center justify-center">
             <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
 <path d="M15 13.5C15 15.1569 13.6569 16.5 12 16.5C10.3431 16.5 9 15.1569 9 13.5C9 11.8431 10.3431 10.5 12 10.5C13.6569 10.5 15 11.8431 15 13.5Z" stroke="#16151C" stroke-width="1.5"/>
 <circle cx="12" cy="7" r="1" fill="#16151C"/>
 <path d="M21 15.5V11.5C21 8.73858 18.7614 6.5 16 6.5H15.874C15.4299 4.77477 13.8638 3.5 12 3.5C10.1362 3.5 8.57006 4.77477 8.12602 6.5H8C5.23858 6.5 3 8.73858 3 11.5V15.5C3 18.2614 5.23858 20.5 8 20.5H16C18.7614 20.5 21 18.2614 21 15.5Z" stroke="#16151C" stroke-width="1.5" stroke-linejoin="round"/>
</svg>
             </div>

           <div class=" grid grid-cols-1 gap-x-6 sm:grid-cols-6">
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >First name</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>

             <div class="sm:col-span-3">
               <label
                 for="last-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Last name</label
               >
               <div >
                 <input
                   v-model="registrationData.last_name"
                   type="text"
                   name="last-name"
                   id="last-name"
                   autocomplete="last-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Mobile Number</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Email Address</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>

             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Date of Birth</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Marital Status</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Gender</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-3">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Nationality</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>
             <div class="sm:col-span-6">
               <label
                 for="first-name"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Address</label
               >
               <div >
                 <input
                   v-model="registrationData.first_name"
                   type="text"
                   name="first-name"
                   id="first-name"
                   autocomplete="first-name"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 dark:placeholder:text-white focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>

             <div class="sm:col-span-2">
           <label
             for="designation"
             class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
             >City</label
           >
           <div >
             <input
               v-model="registrationData.designation"
               type="text"
               name="designation"
               id="designation"
               autocomplete="designation"
               class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
             />
           </div>
         </div>

             <div class="sm:col-span-2">
               <label
                 for="email"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >State</label
               >
               <div >
                 <input
                   v-model="registrationData.email"
                   id="email"
                   name="email"
                   type="email"
                   autocomplete="email"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>

             <div class="sm:col-span-2">
               <label
                 for="email"
                 class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                 >Zip Code</label
               >
               <div >
                 <input
                   v-model="registrationData.email"
                   id="email"
                   name="email"
                   type="email"
                   autocomplete="email"
                   class="block w-full rounded-md border-0 py-1.5 text-gray-900 dark:text-white bg-transparent p-1 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                 />
               </div>
             </div>

             

             <!--div class="col-span-full">
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
             </div-->

       
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
</template>
<script setup>
import { ref, watchEffect } from "vue";
import { useAuthStore } from "../store/auth";
import Navbar from "../components/Navbar.vue";
const isLoading = ref(false);
const authStore = useAuthStore();
const registrationData = {
 // first_name: "",
 // last_name: "",
 // email: "",
 // phone_number: "",
 wallet_address: "",
};
const addData = async () => {
 isLoading.value = true;
 authStore.updateRegistrationData(registrationData);
 // const firstname = authStore.registrationData.first_name;
 // const lastname = authStore.registrationData.last_name;
 // const email = authStore.registrationData.email;
 // const phone = authStore.registrationData.phone_number;
 const address = authStore.registrationData.wallet_address;

 console.log(address);

 try {
   const response = authStore.create_employee(
     // firstname,
     // lastname,
     // email,
     // phone,
     address
   );
   await new Promise((resolve) => setTimeout(resolve, 5000));
 } catch (error) {
   console.error("Error submitting data:", error);
 } finally {
   isLoading.value = false;
   console.error("Successful:");
   router.push("/home/contacts");
 }
};
</script>