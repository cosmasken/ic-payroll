<script setup>
import { useAuthStore } from "./store/auth";
const authStore = useAuthStore();

const registrationData = {
  first_name: "",
  last_name: "",
  email_address: "",
  phone_number: "",
};


//const whoamiActor = authStore.whoamiActor
const logout = () => {
  // router.push("/auth")
  authStore.logout();
};

</script>
<template>
  <main
    
    class=" flex h-full flex-col bg-primary md:min-h-full md:flex-row md:overflow-hidden"
  >
    <div
      class="flex min-h-screen w-full grow flex-col items-center justify-start bg-primary"
    >
      <div class="flex items-center justify-between self-stretch px-6 pt-6">
        <div class="flex gap-2">
          <div class="text-md text-black">
            Signing up as  
          </div>
          <div @click="logout()" class="cursor-pointer text-subtitle-md text-black">
            Sign out
          </div>
        </div>
        <div></div>
      </div>
      <div class="flex w-80 flex-1 flex-col items-center justify-center gap-6">
        <div
          class="flex h-12 w-12 items-center justify-center rounded-lg bg-secondary"
        >
          <img src="./assets/dfinity.svg" alt="Dfinity"  />
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
              <div class="flex-1">
                <input
                  type="text"
                  class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                  placeholder="Display username"
                  value=""
                />
              </div>
            </div>
            <div
              class="flex items-center justify-stretch overflow-hidden rounded-lg border border-wash bg-top-layer p-2"
            >
              <div class="flex-1">
                <input
                  type="text"
                  class="w-full border-0 bg-inherit p-0 shadow-none outline-none ring-0 placeholder:text-disabled focus:shadow-none focus:outline-none focus:ring-0 rounded-l-lg rounded-r-lg text-primary h-[30px] text-body-lg"
                  placeholder="Company name"
                  value=""
                />
              </div>
            </div>
            <div class="relative">
              <button
                class="flex items-center justify-center gap-2 rounded-lg bg-clip-border duration-75 ease-out border border-primary/[.13] bg-secondary text-primary shadow-sm enabled:hover:bg-wash text-subtitle-lg px-5 h-12 w-full"
                data-tooltip-id="daa7b629-823e-4f02-93db-ffda5ffc95de"
              >
                <div class="flex w-full items-center justify-between gap-3">
                  <p class="text-black">Your role</p>
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
                      ></path>
                      </svg></span>
                </div>
                </button >
              <select
                class="absolute inset-y-0 left-2 w-full cursor-pointer opacity-0"
              >
                <option value="" disabled="">Account Type</option>
                <option value="Founder-Execs">
                  Founder &amp; Company Executives
                </option>
                <option value="Business-Owner">Business Owner</option>
                <option value="Employee"></option>
                <option value="Individual">Individual</option>
                <option value="Design-Agency-Freelance">
                  Design Agency &amp; Freelance
                </option>
              </select>
            </div>
          </div>
          <div class="flex w-full flex-col items-stretch gap-4">
            <button
              class="flex items-center justify-center gap-2 rounded-lg bg-clip-border duration-75 ease-out bg-accent text-white enabled:hover:opacity-80 text-subtitle-lg px-5 h-12"
              data-tooltip-id="continue"
              type="submit"
            >
              Continue
            </button>
            <p class="text-center text-body-md text-black">
              By clicking “Continue”, you agree to our
              <a class="text-autom8-blue-500" href="#">Terms</a> and
              acknowledge our
              <a class="text-autom8-blue-500" href="#"
                >Privacy policy</a
              >
            </p>
          </div>
        </form>
      </div>
    </div>
 </main>
</template>
