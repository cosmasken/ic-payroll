<script setup>
import SettingsCard from "../components/SettingsCard.vue";
import NotificationCard from "../components/NotificationCard.vue";
import { useAuthStore } from "../store/auth";
import { ref, watchEffect } from "vue";

const authStore = useAuthStore();

let editing = ref(false);
let originalUser = ref(null);
let email = ref("");
let phone = ref("");
let name = ref("");
let phoneNotifications = ref(false);
let emailNotifications = ref(false);
let user = ref({
  name: "John Doe",
  email: "Johndoe@gmail.com",
  email_notifications: true,
  phone: "09876543123",
  phone_notifications: false,
  wallet: "0x1234567890",
});

const edit = () => {
  // Save a copy of the original user object before editing
  originalUser.value = JSON.parse(JSON.stringify(user));
  editing = true;
};

const save = () => {
  // Save changes
  editing = false;
};
const getTime = () => {
  const date = new Date();
  const time = date.getTime();
  return time;
};

const registrationData = {
  first_name: "",
  last_name: "",
  created_at: getTime(),
  email: "",
  phone_number: "",
  wallet_address: "",
};

watchEffect(async () => {
  const user = await authStore.whoamiActor?.getUser();
  if (user.status === 200) {
    console.log("User:", user.data);
    email.value = await user.data[0].email_address;
    phone.value = await user.data[0].phone_number;
    name.value = await user.data[0].name;
    phoneNotifications.value = await user.data[0].phone_notifications;
    emailNotifications.value = await user.data[0].email_notifications;

  }
});

</script>
<template>
  <div class="card bg-base-100 shadow-xl self-center">
    <div class="mx-auto">
      <div class="avatar online">
        <div class="w-24 rounded-full bg-gray-500"></div>
      </div>
    </div>

    <div class="card-body">
      <div>
        <h2 class="card-title">Profile</h2>
        <p class="uppercase tracking-widest text-gray-800 font-semibold">
          Name: {{ name }}
        </p>
        <p class="uppercase tracking-widest text-gray-800 font-semibold">
          Email: {{ email }}
        </p>
        <p class="uppercase tracking-widest text-gray-800 font-semibold">
          Phone: {{ phone }}
        </p>

        <!--div class="card-actions justify-end">
          <button class="btn btn-primary">Okay</button>
        </div-->
      </div>
    </div>
  </div>
</template>
