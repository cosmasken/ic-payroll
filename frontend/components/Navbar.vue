<!--template>
    <div class="border-b  border-gray-200 pb-5 sm:pb-0 px-5">
      <div class="mt-3 sm:mt-4">
        <div class="sm:hidden">
          <label for="current-tab" class="sr-only">Select a tab</label>
          <select id="current-tab" name="current-tab" class="block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-[#7152F3] focus:outline-none focus:ring-[#7152F3]00 sm:text-sm">
            <option v-for="tab in tabs" :key="tab.name" :selected="tab.current">{{ tab.name }}</option>
          </select>
        </div>
        <div class="hidden sm:block">
          <nav class="-mb-px flex space-x-8">
            <router-link v-for="tab in tabs" :key="tab.name" :to="tab.href" :class="[tab.current ? 'border-[#7152F3] text-[#7152F3]' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700', 'whitespace-nowrap border-b-2 px-1 pb-4 text-sm font-medium']" :aria-current="tab.current ? 'page' : undefined">{{ tab.name }}</router-link>
          </nav>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  const tabs = [
    { name: 'Personal Information', href: '/home/add-employee/personal-information', current: false },
    { name: 'Professional Information', href: '/home/add-employee/professional-information', current: false },
    { name: 'Documents', href: '/home/add-employee/documents', current: true },
    { name: 'Account Access', href: '/home/add-employee/account-access', current: false },
  ]
  </script-->
  <template>
    <div class="border-b border-gray-200 pb-5 sm:pb-0 px-5">
      <div class="mt-3 sm:mt-4">
        <div class="sm:hidden">
          <label for="current-tab" class="sr-only">Select a tab</label>
          <select
            id="current-tab"
            name="current-tab"
            class="block w-full rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-[#7152F3] focus:outline-none focus:ring-[#7152F3]00 sm:text-sm"
            v-model="selectedTab"
          >
            <option v-for="tab in tabs" :key="tab.name" :value="tab">{{ tab.name }}</option>
          </select>
        </div>
        <div class="hidden sm:block">
          <nav class="-mb-px flex space-x-8">
            <router-link
              v-for="tab in tabs"
              :key="tab.name"
              :to="tab.href"
              :class="[
                'whitespace-nowrap border-b-2 px-1 pb-4 text-sm font-medium',
                tab === selectedTab ? 'border-[#7152F3] text-[#7152F3]' : 'border-transparent text-gray-500 hover:border-gray-300 hover:text-gray-700'
              ]"
              @click="selectTab(tab)"
              :aria-current="tab === selectedTab ? 'page' : undefined"
            >
              {{ tab.name }}
            </router-link>
          </nav>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  const tabs = [
    { name: 'Personal Information', href: '/home/add-employee/personal-information' },
    { name: 'Professional Information', href: '/home/add-employee/professional-information' },
    { name: 'Documents', href: '/home/add-employee/documents' },
    { name: 'Account Access', href: '/home/add-employee/account-access' },
  ]
  
  let selectedTab = tabs[0]; // Default selected tab
  
  const selectTab = (tab) => {
    selectedTab = tab;
  }
  </script>
  