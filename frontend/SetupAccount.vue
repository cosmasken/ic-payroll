<script setup>
import { useAuthStore } from "./store/auth";
import { ref, watchEffect, watch } from "vue";
import PhonePicker from "./components/Common/PhonePicker.vue";
import EmailInput from "./components/Common/EmailInput.vue";
import { storeToRefs } from "pinia";
import router from "./router";
const authStore = useAuthStore();

let isLoading = ref(false);
let isRegistered = ref(false);
let emailExists = ref(false);
let name = ref("");
let email = ref("");
let phone = ref("");
let phoneNotifications = ref(false);
let emailNotifications = ref(false);
let accountType = ref("");

const registrationData = {
  first_name: "",
  last_name: "",
  email_address: "",
  phone_number: "",
  account_type: "",
};

function handlePhoneNumberInput(fullNumber) {
  console.log("Full phone number:", fullNumber);
}

watchEffect(async () => {
  const identity = await authStore.whoamiActor?.whoami();
  name.value = identity;
});
watchEffect(async () => {
  const isReg = await authStore.whoamiActor?.isReg();
  console.log("isReg", isReg);
  if (isReg === true) {
    router.push("/home/dashboard");
  }
});

const logout = () => {
  authStore.logout();
};

//const { isRegistered, } = storeToRefs(authStore);

// if(isRegistered.value === true){
//   console.log("User is already registered");
//   router.push("/home/dashboard");
// };

const addData = async () => {
  isLoading.value = true;
  authStore.updateRegistrationData(registrationData);

  const firstname = authStore.registrationData.first_name;
  const lastname = authStore.registrationData.last_name;
  const email = authStore.registrationData.email_address;
  const phone = authStore.registrationData.phone_number;
  const accounttype = authStore.registrationData.account_type;

  const email_notifications = true;
  const phone_notifications = true;

  console.log(
    firstname,
    lastname,
    email,
    phone,
    accounttype,
    phone_notifications,
    email_notifications,
    accounttype
  );

  // Map the string value to the variant type
  let accountTypeVariant;
  switch (accounttype) {
    case "Employee":
      accountTypeVariant = { Employee: null };
      break;
    case "Company":
      accountTypeVariant = { Company: null };
      break;
    case "Freelancer":
      accountTypeVariant = { Freelancer: null };
      break;
    case "Business":
      accountTypeVariant = { Business: null };
      break;
    default:
      throw new Error("Invalid account type");
  }

  try {
    const response = authStore.whoamiActor?.createAccount({
      first_name: firstname,
      last_name: lastname,
      email_notifications: email_notifications,
      email_address: email,
      phone_notifications: phone_notifications,
      phone_number: phone,
      account_type: accountTypeVariant,
      is_verified: true,
    });
    await new Promise((resolve) => setTimeout(resolve, 1000));
  } catch (error) {
    console.error("Error submitting data:", error);
  } finally {
    isLoading.value = false;
    router.push("/home/dashboard");
  }
};
</script>
<template>
  <div v-if="isLoading" class="h-full flex justify-center items-center">
    <div
      class="animate-spin rounded-full h-32 w-32 border-t-2 border-b-2 border-gray-900 self-center"
    ></div>
  </div>
  <main
    v-else
    class="flex h-full flex-col bg-primary md:min-h-full md:flex-row md:overflow-hidden"
  >
    <div
      class="flex min-h-screen w-full grow flex-col items-center justify-start bg-primary"
    >
      <div class="flex items-center justify-between self-stretch px-6 pt-6">
        <div class="flex gap-2">
          <div class="text-md text-black">
            Signing up to BitPochi as {{ name }}
          </div>
          <div
            @click="logout()"
            class="cursor-pointer text-subtitle-md text-black"
          >
            Sign out
          </div>
        </div>
        <div></div>
      </div>
      <div class="flex w-80 flex-1 flex-col items-center justify-center gap-6">
        <div
          class="flex h-12 w-12 items-center justify-center rounded-lg bg-secondary"
        >
          <img src="./assets/dfinity.svg" alt="Dfinity" />
        </div>
        <h1 class="text-headline-md text-primary">Tell us about you</h1>
        <form class="flex w-80 flex-col items-center gap-6">
          <div class="flex w-full flex-col items-stretch gap-4">
            <div class="flex gap-3">
              <div
                class="flex items-center justify-stretch overflow-hidden rounded-lg border border-wash bg-top-layer p-2"
              >
                <div class="flex-1">
                  <input
                    v-model="registrationData.first_name"
                    type="text"
                    class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                    placeholder="First name"
                  />
                </div>
              </div>
              <div
                class="flex items-center justify-stretch overflow-hidden rounded-lg border border-wash bg-top-layer p-2"
              >
                <div class="flex-1">
                  <input
                    v-model="registrationData.last_name"
                    type="text"
                    class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                    placeholder="Last name"
                  />
                </div>
              </div>
            </div>
            <div
              class="flex items-center justify-stretch overflow-hidden rounded-lg border border-wash bg-top-layer p-2"
            >
              <!--div class="flex-1">
              <input
              v-model="registrationData.phone_number"
                type="phone"
                class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                placeholder="Phone Number"
            
              />
              
            </div-->
              <PhonePicker
                v-model="registrationData.phone_number"
                @input="handlePhoneNumberInput"
              />
            </div>
            <div
              class="flex items-center justify-stretch overflow-hidden rounded-lg border border-wash bg-top-layer p-2"
            >
              <!--div class="flex-1">
              <input
              v-model="registrationData.email_address"
                type="email"
                class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                placeholder="Email Address"
                value="youremail@backup.com"
              />
            </div-->
              <EmailInput v-model="registrationData.email_address" />
            </div>
            <div class="relative">
              <button
                class="flex items-center justify-center gap-2 rounded-lg bg-clip-border duration-75 ease-out border border-primary/[.13] bg-secondary text-primary shadow-sm enabled:hover:bg-wash text-subtitle-lg px-5 h-12 w-full"
                data-tooltip-id="daa7b629-823e-4f02-93db-ffda5ffc95de"
              >
                <div class="flex w-full items-center justify-between gap-3">
                  <p class="text-black">
                    {{
                      registrationData.account_type
                        ? registrationData.account_type
                        : "Choose Account Type"
                    }}
                  </p>
                  <span class="text-black shrink-0"
                    ><svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="16px"
                      height="16px"
                      fill="currentColor"
                      viewBox="0 0 256 256"
                    >
                      <path
                        d="M181.66,170.34a8,8,0,0,1,0,11.32l-48,48a8,8,0,0,1-11.32,0l-48-48a8,8,0,0,1,11.32-11.32L128,212.69l42.34-42.35A8,8,0,0,1,181.66,170.34Zm-96-84.68L128,43.31l42.34,42.35a8,8,0,0,0,11.32-11.32l-48-48a8,8,0,0,0-11.32,0l-48,48A8,8,0,0,0,85.66,85.66Z"
                      ></path></svg
                  ></span>
                </div>
              </button>
              <select
                v-model="registrationData.account_type"
                class="absolute inset-y-0 left-2 w-full cursor-pointer opacity-0"
              >
                <option value="Employee">Employee</option>
                <option value="Company">Company</option>
                <option value="Freelancer">Freelancer</option>
                <option value="Business">Business</option>
              </select>
            </div>
          </div>
          <div class="flex w-full flex-col items-stretch gap-4">
            <button
              @click="addData()"
              class="flex items-center justify-center gap-2 rounded-lg bg-clip-border duration-75 ease-out bg-accent text-white enabled:hover:opacity-80 text-subtitle-lg px-5 h-12"
              data-tooltip-id="continue"
              type="button"
            >
              Continue
            </button>
            <p class="text-center text-body-md text-black">
              By clicking “Continue”, you agree to our
              <a class="text-autom8-blue-500" href="#">Terms</a> and acknowledge
              our
              <a class="text-autom8-blue-500" href="#">Privacy policy</a>
            </p>
          </div>
        </form>
      </div>
    </div>
  </main>
</template>
