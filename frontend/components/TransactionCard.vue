<template>
    <div class="container">
      <div class="flex flex-col divide-y rounded-md bg-gray-100 p-6">
        <div class="flex flex-row justify-between pb-3">
          <div class="flex flex-col">
            <div class="flex flex-row items-center">
              <span class="text-mbrs-titlecolor pr-1 text-base">{{ sender }}</span>
              <svg
                width="16"
                height="16"
                viewBox="0 0 16 16"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fill-rule="evenodd"
                  clip-rule="evenodd"
                  d="M4.26698 1.455C4.91024 1.40364 5.52089 1.15063 6.01198 0.731997C6.56664 0.259588 7.27141 0.000137329 7.99998 0.000137329C8.72856 0.000137329 9.43332 0.259588 9.98798 0.731997C10.4791 1.15063 11.0897 1.40364 11.733 1.455C12.4594 1.51305 13.1414 1.82796 13.6567 2.34326C14.172 2.85856 14.4869 3.54057 14.545 4.267C14.596 4.91 14.849 5.521 15.268 6.012C15.7404 6.56666 15.9998 7.27142 15.9998 8C15.9998 8.72857 15.7404 9.43333 15.268 9.988C14.8493 10.4791 14.5963 11.0897 14.545 11.733C14.4869 12.4594 14.172 13.1414 13.6567 13.6567C13.1414 14.172 12.4594 14.4869 11.733 14.545C11.0897 14.5964 10.4791 14.8494 9.98798 15.268C9.43332 15.7404 8.72856 15.9999 7.99998 15.9999C7.27141 15.9999 6.56664 15.7404 6.01198 15.268C5.52089 14.8494 4.91024 14.5964 4.26698 14.545C3.54055 14.4869 2.85855 14.172 2.34325 13.6567C1.82794 13.1414 1.51304 12.4594 1.45498 11.733C1.40362 11.0897 1.15061 10.4791 0.731982 9.988C0.259573 9.43333 0.00012207 8.72857 0.00012207 8C0.00012207 7.27142 0.259573 6.56666 0.731982 6.012C1.15061 5.52091 1.40362 4.91026 1.45498 4.267C1.51304 3.54057 1.82794 2.85856 2.34325 2.34326C2.85855 1.82796 3.54055 1.51305 4.26698 1.455ZM11.707 6.707C11.8891 6.51839 11.9899 6.26579 11.9877 6.0036C11.9854 5.7414 11.8802 5.49059 11.6948 5.30518C11.5094 5.11977 11.2586 5.0146 10.9964 5.01232C10.7342 5.01004 10.4816 5.11084 10.293 5.293L6.99998 8.586L5.70698 7.293C5.51838 7.11084 5.26578 7.01005 5.00358 7.01232C4.74138 7.0146 4.49057 7.11977 4.30516 7.30518C4.11976 7.49059 4.01459 7.7414 4.01231 8.0036C4.01003 8.26579 4.11082 8.51839 4.29298 8.707L6.29298 10.707C6.48051 10.8945 6.73482 10.9998 6.99998 10.9998C7.26515 10.9998 7.51945 10.8945 7.70698 10.707L11.707 6.707Z"
                  fill="#0066FF"
                ></path>
              </svg>
            </div>
            <p class="truncate text-sm leading-6 text-black">Transaction Id : {{ id }}</p>
          </div>
          <div>
            <span
              class="inline-flex items-center rounded-full space-x-2 bg-green-50 px-2 py-1 text-xs font-medium text-green-700 ring-1 ring-inset ring-green-600/20"
            >
              <!--div class="pr-2">
                <svg class="h-1.5 w-1.5 fill-green-500" viewBox="0 0 6 6" aria-hidden="true">
                  <circle cx="3" cy="3" r="3" />
                </svg>
              </div-->
              
              {{ created_at }}</span
            >
          </div>
        </div>
        <div class="pt-3 space-y-4">
          <div class="grid grid-cols-1 items-center gap-6 md:grid-cols-3 lg:grid-cols-6">
            <div class="md:col-span-1 lg:col-span-2">
              <p class="text-xs text-gray-500">Sender.</p>
              <p class="text-gray-900 text-sm">{{ sender }}</p>
            </div>
            <div class="md:col-span-1 lg:col-span-2">
              <p class="text-xs text-gray-500">Receiver</p>
              <p class="text-gray-900 text-sm">{{ receiver }}</p>
            </div>
            <div class="md:col-span-1 lg:col-span-2">
              <p class="text-xs text-gray-500">Amount</p>
              <p class="text-green-500 text-sm font-bold">{{ amount }} ckSats</p>
            </div>
          </div>
         
        </div>
      </div>
    </div>
  </template>
  <script setup>
  const props = defineProps([
    'sender',
    'id',
    'receiver',
    'amount',
    'created_at'
  ]);

 // let myDate = new Date(timestamp.seconds * 1000)

  </script>
  