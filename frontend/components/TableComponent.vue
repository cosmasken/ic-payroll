<script setup>
import { ref } from "vue"

defineProps({
  msg: String,
})

const count = ref(0)
</script>

<template>
  <div>
    <div>
      <table class="divide-y divide-gray-500 w-full">
        <thead class="bg-white dark:bg-transparent">
          <tr>
            <th
              scope="col"
              class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
            >
              Employee Name
            </th>
            <th
              scope="col"
              class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
            >
              Employee CTC
            </th>
            <th
              scope="col"
              class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
            >
              Salary
            </th>
            <th
              scope="col"
              class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
            >
              Deduction
            </th>
            <th
              scope="col"
              class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
            >
              Status
            </th>
            <!--th
                        scope="col"
                        class="py-[10px] pr-[10px] text-left text-base font-light text-[#A2A1A8]"
                      >
                        Action
                      </th-->
          </tr>
        </thead>
        <tbody class="divide-y divide-gray-200 bg-transparent">
          <tr>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                Cosmas Ken
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                $45000
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$4000</div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$400</div>
            </td>
            <td class="whitespace-nowrap py-[10px] text-base">
              <div
                class="font-light text-[#3FC28A] bg-[#3FC28A]/10 rounded-[4px] py-[3px] px-2"
              >
                Completed
              </div>
            </td>
            <!--td
                        class="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6"
                      >
                        <div class="flex flex-row items-center justify-end space-x-4">
                          <button
                            type="button"
                            class="inline-flex items-center rounded bg-white px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="18"
                              height="20"
                              viewBox="0 0 18 20"
                              fill="none"
                            >
                              <path
                                d="M12.3333 5.00002V4.33335C12.3333 3.39993 12.3333 2.93322 12.1517 2.5767C11.9919 2.2631 11.7369 2.00813 11.4233 1.84834C11.0668 1.66669 10.6001 1.66669 9.66667 1.66669H8.33333C7.39991 1.66669 6.9332 1.66669 6.57668 1.84834C6.26308 2.00813 6.00811 2.2631 5.84832 2.5767C5.66667 2.93322 5.66667 3.39993 5.66667 4.33335V5.00002M7.33333 9.58335V13.75M10.6667 9.58335V13.75M1.5 5.00002H16.5M14.8333 5.00002V14.3334C14.8333 15.7335 14.8333 16.4336 14.5608 16.9683C14.3212 17.4387 13.9387 17.8212 13.4683 18.0609C12.9335 18.3334 12.2335 18.3334 10.8333 18.3334H7.16667C5.76654 18.3334 5.06647 18.3334 4.53169 18.0609C4.06129 17.8212 3.67883 17.4387 3.43915 16.9683C3.16667 16.4336 3.16667 15.7335 3.16667 14.3334V5.00002"
                                stroke="#F0372B"
                                stroke-width="1.66667"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              ></path>
                            </svg>
                          </button>
                          <button
                            type="button"
                            class="inline-flex items-center rounded bg-white px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                            x-data="{id:'import-workflow-modal'}"
                            x-on:click="$dispatch('modal-overlay',{id})"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="20"
                              height="18"
                              viewBox="0 0 20 18"
                              fill="none"
                              stroke="currentColor"
                            >
                              <path
                                d="M6.66602 13.1667L9.99935 16.5M9.99935 16.5L13.3327 13.1667M9.99935 16.5V9M16.666 12.9524C17.6839 12.1117 18.3327 10.8399 18.3327 9.41667C18.3327 6.88536 16.2807 4.83333 13.7493 4.83333C13.5673 4.83333 13.3969 4.73833 13.3044 4.58145C12.2177 2.73736 10.2114 1.5 7.91602 1.5C4.46424 1.5 1.66602 4.29822 1.66602 7.75C1.66602 9.47175 2.36222 11.0309 3.48847 12.1613"
                                stroke-width="1.67"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              ></path>
                            </svg>
                          </button>
                          <button
                            type="button"
                            class="inline-flex items-center rounded bg-white px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                            x-data="{id:'export-workflow-modal'}"
                            x-on:click="$dispatch('modal-overlay',{id})"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="20"
                              height="18"
                              viewBox="0 0 20 18"
                              fill="none"
                              stroke="currentColor"
                            >
                              <path
                                d="M6.66602 12.3333L9.99935 9M9.99935 9L13.3327 12.3333M9.99935 9V16.5M16.666 12.9524C17.6839 12.1117 18.3327 10.8399 18.3327 9.41667C18.3327 6.88536 16.2807 4.83333 13.7493 4.83333C13.5673 4.83333 13.3969 4.73833 13.3044 4.58145C12.2177 2.73736 10.2114 1.5 7.91602 1.5C4.46424 1.5 1.66602 4.29822 1.66602 7.75C1.66602 9.47175 2.36222 11.0309 3.48847 12.1613"
                                stroke-width="1.67"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              ></path>
                            </svg>
                          </button>
                          <a
                            href="./workflow-config.html"
                            class="inline-flex items-center rounded bg-white px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="16"
                              height="16"
                              viewBox="0 0 16 16"
                              fill="none"
                              stroke="currentColor"
                            >
                              <path
                                d="M8.00065 2.99998V1.33331M8.00065 2.99998C7.08018 2.99998 6.33398 3.74617 6.33398 4.66665C6.33398 5.58712 7.08018 6.33331 8.00065 6.33331M8.00065 2.99998C8.92113 2.99998 9.66732 3.74617 9.66732 4.66665C9.66732 5.58712 8.92113 6.33331 8.00065 6.33331M3.00065 13C3.92113 13 4.66732 12.2538 4.66732 11.3333C4.66732 10.4128 3.92113 9.66665 3.00065 9.66665M3.00065 13C2.08018 13 1.33398 12.2538 1.33398 11.3333C1.33398 10.4128 2.08018 9.66665 3.00065 9.66665M3.00065 13V14.6666M3.00065 9.66665V1.33331M8.00065 6.33331V14.6666M13.0007 13C13.9211 13 14.6673 12.2538 14.6673 11.3333C14.6673 10.4128 13.9211 9.66665 13.0007 9.66665M13.0007 13C12.0802 13 11.334 12.2538 11.334 11.3333C11.334 10.4128 12.0802 9.66665 13.0007 9.66665M13.0007 13V14.6666M13.0007 9.66665V1.33331"
                                stroke-width="1.67"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              ></path>
                            </svg>
                          </a>
                          <button
                            type="button"
                            class="inline-flex items-center rounded bg-white px-1 py-1 text-sm font-medium leading-4 text-gray-700 hover:text-gray-900 hover:bg-gray-50"
                            x-data="{id:'edit-workflow-modal'}"
                            x-on:click="$dispatch('modal-overlay',{id})"
                          >
                            <svg
                              xmlns="http://www.w3.org/2000/svg"
                              width="19"
                              height="19"
                              viewBox="0 0 19 19"
                              fill="none"
                              stroke="currentColor"
                            >
                              <path
                                d="M1.39735 15.0964C1.43564 14.7518 1.45478 14.5795 1.50691 14.4185C1.55316 14.2756 1.61851 14.1396 1.70118 14.0142C1.79436 13.8729 1.91694 13.7504 2.16209 13.5052L13.1673 2.49999C14.0878 1.57951 15.5802 1.57951 16.5007 2.49999C17.4211 3.42046 17.4211 4.91285 16.5007 5.83332L5.49542 16.8386C5.25027 17.0837 5.1277 17.2063 4.98639 17.2995C4.86102 17.3821 4.72506 17.4475 4.58219 17.4937C4.42115 17.5459 4.24887 17.565 3.90429 17.6033L1.08398 17.9167L1.39735 15.0964Z"
                                stroke-width="1.66667"
                                stroke-linecap="round"
                                stroke-linejoin="round"
                              ></path>
                            </svg>
                          </button>
                        </div>
                      </td-->
          </tr>
          <tr>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                Cosmas Ken
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                $45000
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$4000</div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$400</div>
            </td>
            <td class="whitespace-nowrap py-[10px] text-base">
              <div
                class="font-light text-[#3FC28A] bg-[#3FC28A]/10 rounded-[4px] py-[3px] px-2"
              >
                Completed
              </div>
            </td>
          </tr>
          <tr>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                Cosmas Ken
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">
                $45000
              </div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$4000</div>
            </td>
            <td class="whitespace-nowrap py-[10px] pr-[10px] text-base">
              <div class="font-light dark:text-white text-[#16151C]">$400</div>
            </td>
            <td class="whitespace-nowrap py-[10px] text-base">
              <div
                class="font-light text-[#3FC28A] bg-[#3FC28A]/10 rounded-[4px] py-[3px] px-2"
              >
                Completed
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
