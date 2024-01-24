<script setup>
const tabs = [
  {
    name: "Personal Information",
    href: "/personal-information",
    current: false,
  },
  {
    name: "Professional Information",
    href: "/professional-information",
    current: false,
  },
  { name: "Documents", href: "/documents", current: true },
  { name: "Account Access", href: "/account-access", current: false },
];
</script>
<template>
  <!--MultiStepForm :steps="['Personal information 👶','Series 📺','Feedback 🌟']"/-->

  <div class="p-5">
    <div>
      <div class="sm:hidden">
        <label for="tabs" class="sr-only">Select a tab</label>

        <select
          id="tabs"
          name="tabs"
          class="block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
        >
          <option v-for="tab in tabs" :key="tab.name" :selected="tab.current">
            {{ tab.name }}
          </option>
        </select>
      </div>
      <div class="hidden sm:block">
        <div class="border-b border-gray-200">
          <nav class="-mb-px flex space-x-8" aria-label="Tabs">
            <router-link
              v-for="tab in tabs"
              :key="tab.name"
              :to="tab.href"
              :class="[
                tab.current
                  ? 'border-indigo-500 text-indigo-600'
                  : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700',
                'whitespace-nowrap border-b-2 py-4 px-1 text-sm font-medium',
              ]"
              :aria-current="tab.current ? 'page' : undefined"
              >{{ tab.name }}</router-link
            >
          </nav>
        </div>
      </div>
    </div>
  </div>
</template>
