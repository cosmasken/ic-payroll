<template>
<!--div class="flex items-center justify-center h-screen bg-gray-900"-->
      <div class="dark:bg-gray-800 bg-white rounded-lg shadow-xl p-8 w-full h-full">
        <div class="mb-4">
          <h1 class="font-semibold text-gray-50">Notifications</h1>
        </div>
        <div class=" p-2 " v-for="notification in notifications" :key="notification.id">
          <div class="flex items-center mb-4 p-2 rounded-[10px] border border-gray-600">
          <div class="mr-4">
            <button class="inline-flex items-center justify-center w-14 h-14 text-blue-100 bg-gray-700 rounded-full">
            gg    
            </button>
          </div>
          <div>
            <p class="font-semibold dark:text-gray-50 text-gray-800">You received a payment of <span class="text-blue-500 font-bold">{{ notification.amount}}</span> from {{notification.sender}}</p>
            <span class="text-xs dark:text-gray-500 text-gray-800">12 min ago</span>
          </div>
        </div>
         
     </div>      
      </div>
 
</template>
<script setup>
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";
import TransactionCard from "../components/TransactionCard.vue"
const authStore = useAuthStore();
let notifications = ref([]);


watchEffect(async () => {
  const res = await authStore.whoamiActor?.getNotifications();
  notifications.value = await res;
  console.log(res);
});


</script>
