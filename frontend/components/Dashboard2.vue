<script setup>
import OverviewCard from './Dashboard/OverviewCard.vue';
import LeaveCard from './Leave/LeaveCard.vue';
const filter = [
  {
    id: 1,
    name: "Daily",
  },
  {
    id: 2,
    name: "Monthly",
  },
  {
    id: 3,
    name: "Yearly",  
  },
];
</script>

<template>
  <!--main
    class="flex-1 flex flex-col min-h-full px-4 md:px-6 lg:px-7 pt-4 md:pt-6"
  >
    <div class="mb-6">
     

      <div class="flex flex-col sm:flex-row sm:justify-between">
        <h2 class="text-lg lg:text-xl font-semibold text-gray-900">
        Dashboard Overview
      </h2>
      <div class="grid grid-cols-1 sm:grid-cols-2 gap-2">
        <select
                        id="report-filter"
                        name="report-filter"
                        class="mt-1 block w-full rounded-md border-gray-300 px-3 pr-10 text-base focus:border-autom8-blue-500 focus:outline-none focus:ring-autom8-blue-500 sm:text-sm"
                      >
                        <option>Monthly</option>
                        <option>Daily</option>
                        <option>Annually</option>
                      </select>
        <button
              type="button"
              class="inline-flex items-center justify-center sm:w-40 min-w-[125px] rounded-md border border-autom8-blue-500 bg-autom8-blue-500 px-3 py-2 text-sm space-x-2 font-medium leading-4 text-white shadow-sm hover:bg-autom8-blue-600 hover:border-autom8-blue-600 focus:outline-none focus:ring-2 focus:ring-autom8-blue-500 focus:ring-offset-2"
              
            >
              Download
            </button>
      </div>
        </div>

        <!--div class="flex flex-col md:flex-row">

          <div class="flex basis-3/4">
            <div class="flex flex-col sm:flex-row">
              <OverviewCard
            header="Employee Joined"
            currency1="10"
            headercolor="#1F2937"
            currency1color="#4C98FF"
            balance="500"
          />
          <OverviewCard
            header="Employee Turnover"
            currency1="20"
            headercolor="#1F2937"
            currency1color="#4C98FF"
            balance="500"
          />
          <OverviewCard
            header="Lent Assets"
            currency1="$1400"
            headercolor="#1F2937"
            currency1color="#4C98FF"
            balance="500"
          />
              </div>
           
            </div>

            <div class="flex basis-1/4 bg-green-500 w-full">
           
           <LeaveCard
            presentheader="Present"
            absentheader="Absent"
            leaveheader="Leave"
            present="90"
            absent="4"
            leave="3"
          />
            </div>

        </div-->
       
    </div>
  </main-->
</template>
