<template>
     <div class="overflow-hidden rounded-lg bg-white relative">
            <button
              class="flex items-center w-full justify-between text-sm font-medium"
            >
              <div class="flex flex-row justify-between w-full bg-white p-1">
                <div
                  class="flex flex-row bg-backdrop items-center justify-between rounded px-3 w-[80%]"
                >
                  <div>
                    <p
                      class="text-[9px] -mb-1 text-left font-medium text-gray-600 group-hover:text-white"
                    >
                      INDIVIDUAL ACCOUNT
                    </p>
                    <p
                      class="text-[0.9rem] text-left font-semibold text-gray-900 group-hover:text-gray-400"
                    >
                      Ada Robin
                    </p>
                  </div>
                  <div class="border rounded-md p-1.5 hover:bg-gray-100">
                    <svg
                      class="rotate-0 transform w-3 h-3 text-gray-500 transform rotate-0"
                      xmlns="http://www.w3.org/2000/svg"
                      width="10"
                      height="7"
                      viewBox="0 0 10 7"
                      fill="none"
                    >
                      <path
                        fill-rule="evenodd"
                        clip-rule="evenodd"
                        d="M0.293081 0.792971C0.480608 0.6055 0.734916 0.500184 1.00008 0.500184C1.26524 0.500184 1.51955 0.6055 1.70708 0.79297L5.00008 4.08597L8.29308 0.79297C8.48168 0.610812 8.73428 0.510018 8.99648 0.512296C9.25868 0.514574 9.50949 0.619743 9.6949 0.805151C9.88031 0.990559 9.98548 1.24137 9.98775 1.50357C9.99003 1.76577 9.88924 2.01837 9.70708 2.20697L5.70708 6.20697C5.51955 6.39444 5.26525 6.49976 5.00008 6.49976C4.73492 6.49976 4.48061 6.39444 4.29308 6.20697L0.293081 2.20697C0.10561 2.01944 0.000294271 1.76513 0.000294248 1.49997C0.000294225 1.23481 0.105609 0.980498 0.293081 0.792971Z"
                        fill="#B2B9C0"
                      ></path>
                    </svg>
                  </div>
                </div>
                <div class="h-10 w-10 bg-backdrop rounded-full overflow-hidden">
                  <img src="/src/images/profile.png" class="w-full h-full" />
                </div>
              </div></button
            >
            <!-- DROPDOWN SECTION -->
            <div>
              <!-- level 1 dropdown -->
              <ul
                x-transition:enter="transform transition ease-in-out duration-75"
                x-transition:enter-start=" opacity-0"
                x-transition:enter-end="opacity-100"
                x-transition:leave="transform transition ease-in-out duration-75"
                x-transition:leave-start="opacity-100"
                x-transition:leave-end="opacity-0"
                class="max-w-ful scrollbar absolute z-10 mt-1 max-h-60 w-full overflow-auto overflow-x-clip rounded-md bg-white px-1 py-1 text-base shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none sm:w-full sm:text-sm"
                tabindex="-1"
                role="listbox"
                aria-labelledby="listbox-label"
                aria-activedescendant="listbox-option-3"
                style="display: none"
              >
                <li
                  class="relative cursor-default select-none bg-[#EAECF5] py-2 pr-9 text-gray-900"
                  id="listbox-option-0"
                  role="option"
                >
                  <div class="flex items-center text-sm leading-4">
                    <!-- Selected: "font-medium", Not Selected: "font-normal" --><span
                      class="ml-3 block whitespace-nowrap font-medium"
                      ><span>BUSINESS ACCOUNT</span><br /><span
                        class="m-0 pb-0 text-xs font-normal text-gray-500"
                        >Bizimungu and Daughters Associates Limited
                      </span></span
                    >
                  </div>
                  <span
                    class="text-mbrs-titlecolor absolute inset-y-0 right-0 flex items-center pr-4"
                    ><svg
                      class="h-4 w-4"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 16 16"
                    >
                      <path
                        fill="currentColor"
                        fill-rule="evenodd"
                        d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16Zm3.707-9.293a1 1 0 0 0-1.414-1.414L7 8.586 5.707 7.293a1 1 0 0 0-1.414 1.414l2 2a1 1 0 0 0 1.414 0l4-4Z"
                        clip-rule="evenodd"
                      ></path></svg
                  ></span>
                </li>
              </ul>
              <!-- level 1 dropdown -->
            </div>
            <!-- flag section -->
            <div>
              <div class="h-36 w-full relative overflow-hidden">
                <img
                  src="/src/images/flag.png"
                  alt="Malawi"
                  class="absolute top-0 left-0 min-w-full min-h-full"
                />
              </div>
              <!-- user section -->
              <div class="flex space-x-2 pb-6 px-6">
                <div
                  class="flex-shrink relative -top-5 -mb-5 rounded-full border-1 border-white md:h-22 md:w-22"
                >
                  <img
                    class="w-[96px] h-[96px]"
                    src="/src/images/profile.png"
                    alt=""
                  />
                </div>
                <div class="pt-2 flex-grow max-w-[70%]">
                  <p
                    class="text-black-600 text-left text-xl font-semibold whitespace-nowrap overflow-hidden overflow-ellipsis"
                  >
                    Ada Robin Kasopa
                  </p>
                  <p class="text-sm font-medium text-left">SA12I456G</p>
                </div>
              </div>
              <div style="display: none">
                <div
                  class="relative inset-0 flex items-center px-6"
                  aria-hidden="true"
                >
                  <div class="w-full border-t border-gray-300"></div>
                </div>
                <div class="p-6 space-y-1 bg-white rounded">
                  <a
                    href="/organization/services"
                    class="hover:bg-gray-50 group flex items-center px-4 py-3 text-sm font-medium rounded-md"
                    ><span>Home</span></a
                  ><a
                    href="/organization/companydetails"
                    class="hover:bg-gray-50 group flex items-center px-4 py-3 text-sm font-medium rounded-md"
                    ><span>Company Details</span></a
                  ><a
                    href="/organization/annualreturns"
                    class="hover:bg-gray-50 group flex items-center px-4 py-3 text-sm font-medium rounded-md"
                    ><span>Annual Returns</span></a
                  ><a
                    href="/organization/accesscontrol"
                    class="hover:bg-gray-50 group flex items-center px-4 py-3 text-sm font-medium rounded-md"
                    ><span>Access Control</span></a
                  ><a
                    href="/organization/audittrail"
                    class="hover:bg-gray-50 group flex items-center px-4 py-3 text-sm font-medium rounded-md"
                    ><span>Audit Trail</span></a
                  >
                </div>
              </div>
              <!-- company section -->
            </div>
          </div>
</template>