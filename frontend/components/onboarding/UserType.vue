<!-- <script setup>
import { useCompanyStore } from "../../store/company"

const companyStore = useCompanyStore()
</script>
<template>
    <div>
        <p class="text-[22px] font-semibold text-grey dark:text-white">Account Type</p>
        <button @click="companyStore.setIsInitialized(true)">I'm a company</button>
        <button @click="companyStore.setIsInitialized(false)">I'm a freelancer</button>
    </div>
</template> -->

<template>
    <RadioGroup v-model="selectedMailingLists">
      <RadioGroupLabel class="text-base font-semibold leading-6 text-gray-900">Select Account Type</RadioGroupLabel>
  
      <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
        <RadioGroupOption as="template" v-for="mailingList in mailingLists" :key="mailingList.id" :value="mailingList" v-slot="{ active, checked }">
          <div :class="[active ? 'border-indigo-600 ring-2 ring-indigo-600' : 'border-gray-300', 'relative flex cursor-pointer rounded-lg border bg-white p-4 shadow-sm focus:outline-none']">
            <span class="flex flex-1">
              <span class="flex flex-col">
                <RadioGroupLabel as="span" class="block text-sm font-medium text-gray-900">{{ mailingList.title }}</RadioGroupLabel>
                 </span>
            </span>
            <CheckCircleIcon :class="[!checked ? 'invisible' : '', 'h-5 w-5 text-indigo-600']" aria-hidden="true" />
            <span :class="[active ? 'border' : 'border-2', checked ? 'border-indigo-600' : 'border-transparent', 'pointer-events-none absolute -inset-px rounded-lg']" aria-hidden="true" />
          </div>
        </RadioGroupOption>
      </div>
    </RadioGroup>
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { RadioGroup, RadioGroupDescription, RadioGroupLabel, RadioGroupOption } from '@headlessui/vue'
  import { CheckCircleIcon } from '@heroicons/vue/20/solid'
  
  const mailingLists = [
    { id: 1, title: 'Business',  },
    { id: 2, title: 'Individual' },
  ]
  
  const selectedMailingLists = ref(mailingLists[0])
  </script>