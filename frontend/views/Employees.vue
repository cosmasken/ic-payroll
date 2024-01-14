<script setup>
import { ref } from 'vue'
import Searchbar from '../components/Searchbar.vue'
import router from '../router/'
import { ChevronLeftIcon, ChevronRightIcon } from '@heroicons/vue/20/solid'

const isEmpty = ref(true)

const gotoaddemployee = () => {
  router.push('/add-employee/')
}

const employees = [
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '23',
    type: 'office',
    status: 'Permannet'
  },
  // More people...
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '45',
    type: 'office',
    status: 'Permannet'
  },
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '7567',
    type: 'office',
    status: 'Permannet'
  },
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '786',
    type: 'office',
    status: 'Permannet'
  },
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '243',
    type: 'office',
    status: 'Permannet'
  },
  {
    name: 'Lindsay Walton',
    designation: 'Front-end Developer',
    department: 'Frontend',
    id: '687',
    type: 'office',
    status: 'Permannet'
  }
]
</script>
<template>
  <div class="p-5 flex flex-col">
    <div class="flex flex-row justify-between items-center">
      <Searchbar />
      <div class="flex flex-row space-x-5">
        <div
          @click="gotoaddemployee()"
          class="rounded-[10px] cursor-pointer flex flex-row  bg-[#7152F3] p-3 items-center space-x-[10px]"
        >
          <img src="../assets/add-circle.png" alt="" class="w-6 h-6" />
          <p class="text-base font-light text-white">Add New Employee</p>
        </div>
        <div
          class="rounded-[10px] flex flex-row cursor-pointer border border-[#A2A1A833] p-3 items-center space-x-[10px]"
        >
          <img src="../assets/filter.png" alt="" class="w-6 h-6" />
          <p class="text-base font-light dark:text-white text-[#16151C]">Filter</p>
        </div>
      </div>
    </div>

    <!-- Table-->
    <div class="flow-root">
      <div class="overflow-x-auto">
        <div class="inline-block min-w-full border-b border-gray-300 align-middle">
          <table class="min-w-full divide-y divide-gray-300">
            <thead>
              <tr>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Employee Name
                </th>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Employee ID
                </th>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Department
                </th>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Designation
                </th>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Type
                </th>
                <th
                  scope="col"
                  class="pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Status
                </th>

                <th
                  scope="col"
                  class="relative pr-[10px] py-[10px] text-left text-base text-accentgray font-light"
                >
                  Action
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-300">
              <tr v-for="person in employees" :key="person.id">
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.name }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.id }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.department }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.designation }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.type }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  {{ person.status }}
                </td>
                <td
                  class="pr-[10px] py-[10px] text-left text-base text-[#16151C] dark:text-white font-light"
                >
                  <div class="flex flex-row space-x-[10px]">
                    <div class="cursor-pointer">
                      <img src="../assets/view.png" alt="" class="w-6 h-6" />
                    </div>
                    <div class="cursor-pointer">
                      <img src="../assets/edit.png" alt="" class="w-6 h-6" />
                    </div>
                    <div class="cursor-pointer">
                      <img src="../assets/trash.png" alt="" class="w-6 h-6" />
                    </div>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="flex flex-row justify-between pt-[14px] items-center">
      <div class="flex flex-row space-x-5 items-center">
        <p class="text-accentgray text-sm leading-[22px] font-light">Showing</p>
        <div
          class="rounded-[10px] border border-bordercolor flex flex-row h-[46px] w-[76px] items-center justify-around"
        >
          <p class="text-accentgray text-sm leading-[22px] font-light">10</p>
          <img src="../assets/direction-down 01.png" alt="" class="w-6 h-6" />
        </div>
      </div>

      <div>
        <p class="text-accentgray dark:text-white text-sm leading-[22px] font-light">
          Showing
          {{ ' ' }}
          <span class="font-medium">1</span>
          {{ ' ' }}
          to
          {{ ' ' }}
          <span class="font-medium">10</span>
          {{ ' ' }}
          out of
          {{ ' ' }}
          <span class="font-medium">97</span>
          {{ ' ' }}
          Records
        </p>
      </div>

      <div>
        <nav class="isolate inline-flex -space-x-px rounded-md shadow-sm" aria-label="Pagination">
          <a
            href="#"
            class="relative inline-flex items-center rounded-l-md px-2 py-2 text-gray-400 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:z-20 focus:outline-offset-0"
          >
            <span class="sr-only">Previous</span>
            <ChevronLeftIcon class="h-5 w-5" aria-hidden="true" />
          </a>
          <!-- Current: "z-10 bg-indigo-600 text-white focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600", Default: "text-gray-900 ring-1 ring-inset ring-gray-300 hover:bg-gray-50 focus:outline-offset-0" -->
          <a
            href="#"
            aria-current="page"
            class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset focus-visible:outline-[#7152F3]"
            >1</a
          >
          <a
            href="#"
            class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset focus-visible:outline-[#7152F3]"
            >2</a
          >
          <a
            href="#"
            class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
            >3</a
          >
          <span
            class="relative inline-flex items-center px-4 py-2 text-sm font-semibold text-gray-700 ring-1 ring-inset ring-gray-300 focus:outline-offset-0"
            >...</span
          >

          <a
            href="#"
            class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
            >9</a
          >
          <a
            href="#"
            class="text-accentgray text-sm leading-[22px] font-light px-3 py-[7px] relative inline-flex items-center ring-1 ring-inset"
          >
            <span class="sr-only">Next</span>
            <ChevronRightIcon class="h-5 w-5" aria-hidden="true" />
          </a>
        </nav>
      </div>
    </div>
  </div>
</template>
