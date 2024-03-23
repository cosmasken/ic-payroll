<template>
  <div class="flex flex-col">
    <div class="flex flex-row justify-between">
      <div class="flex flex-row">
        <img src="../assets/attendance.png" />

        <div class="flex flex-col">
          <p>Brookline Simons</p>
          <div class="flex flex-row">
            <img src="../assets/add-circle.png" class="h-5 w-5" />
            <p>Brookline Simons</p>
          </div>
          <div class="flex flex-row">
            <img src="../assets/add-circle.png" class="h-5 w-5" />
            <p>Brookline Simons</p>
          </div>
        </div>
      </div>
      <div>
        <button class="bg-primary-500 rounded-[10px] p-5">Edit</button>
      </div>
    </div>

    <div class="flex flex-row">
      <div class="flex flex-col w-[242px] rounded-[10px]">
        <router-link
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D]  text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer  text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/settings"
        >
          <span>Profile</span>
        </router-link>
        <router-link
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D]  text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer  text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/settings"
        >
          <span>Attendance</span>
        </router-link>
        <router-link
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D]  text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer  text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/settings"
        >
          <span>Projects</span>
        </router-link>
        <router-link
          active-class="group router-link-exact-active cursor-pointer flex flex-row bg-[#7152F30D]  text-base text-[#7152F3] font-semibold py-[13px] pr-[10px] pl-[13px] space-x-4"
          class="group flex flex-row bg-[#7152F30D] cursor-pointer  text-base text-[#16151C] dark:text-gray-400 font-light hover:bg-[#7152F30D] py-[13px] pr-[10px] pl-[13px] space-x-4"
          to="/home/settings"
        >
          <span>Leave</span>
        </router-link>
      </div>
      <div class="flex flex-col">
        <div class="flex flex-row justify-between"></div>

        <router-view></router-view>
      </div>
    </div>
  </div>
</template>
<script setup></script>
