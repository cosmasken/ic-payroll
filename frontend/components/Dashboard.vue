<script setup>
import OverviewCard from "./Dashboard/OverviewCard.vue";
import LeaveCard from "./Leave/LeaveCard.vue";
import {
  Chart as ChartJS,
  ArcElement,
  Legend,
  Title,
  Tooltip,
  BarElement,
  CategoryScale,
  LinearScale,
} from "chart.js";
import { Bar } from "vue-chartjs";
import { Doughnut } from "vue-chartjs";
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
const data = {
  labels: ["Men", "Women"],
  datasets: [
    {
      backgroundColor: ["#41B883", "#E46651"],
      data: [50, 50],
    },
  ],
};

const options = {
  responsive: true,
  maintainAspectRatio: false,
};
const chartData = {
  labels: [
    "January",
    "February",
    "March",
    "January",
    "February",
    "March",
    "January",
    "February",
    "March",
  ],
  datasets: [{ data: [40, 20, 12, 40, 20, 12, 40, 20, 12] }],
};
const chartOptions = {
  responsive: true,
};
ChartJS.register(
  ArcElement,
  Title,
  Tooltip,
  Legend,
  BarElement,
  CategoryScale,
  LinearScale
);
</script>
<template>
  <div class="h-full w-full">
    <main>
      <div class="xl:pr-96">
        <div class="px-4 py-10 sm:px-6 lg:px-8 lg:py-6">
          <!-- Main area -->
          <div class="flex flex-col">
            <div
              class="flex flex-col sm:flex-row space-y-2 sm:space-y-0 sm:space-x-2"
            >
              <OverviewCard
                header="Employee Joined"
                currency1="10"
                headercolor="#1F2937"
                currency1color="#4C98FF"
                balance="0"
              />
              <OverviewCard
                header="Employee Turnover"
                currency1="20"
                headercolor="#1F2937"
                currency1color="#4C98FF"
                balance="0"
              />
              <OverviewCard
                header="Lent Assets"
                currency1="$1400"
                headercolor="#1F2937"
                currency1color="#4C98FF"
                balance="0"
              />
            </div>

            <!-- Graph area  show donut chart using css to show 50 % men and women-->
            <div class="grid grid-cols-1 sm:grid-cols-2">
              <Doughnut :data="data" :options="options" />
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2">
              <Bar id="my-chart-id" :options="chartOptions" :data="chartData" />
            </div>
          </div>
        </div>
      </div>
    </main>

    <aside
      class="fixed inset-y-0 right-0 hidden w-96 overflow-y-auto border-l border-gray-200 px-4 py-24 sm:px-6 lg:px-8 xl:block"
    >
      <!-- Secondary column (hidden on smaller screens) -->
      <div class="flex flex-col">
        <LeaveCard
          presentheader="Present"
          absentheader="Absent"
          leaveheader="Leave"
          present="0"
          absent="0"
          leave="0"
        />
      </div>
    </aside>
  </div>
</template>
