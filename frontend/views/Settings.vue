<script setup>
import SettingsCard from "../components/SettingsCard.vue"
import NotificationCard from "../components/NotificationCard.vue"
</script>
<template>
  <div class="flex flex-col p-5 divide-y divide-[#A2A1A81A]">
    <SettingsCard
      heading="Appearance"
      subtitle="Customize how your theme looks on your device"
      btnText="Light"
    />
    <SettingsCard
      heading="Language"
      subtitle="Select your language"
      btnText="Language"
    />
    <NotificationCard
      heading="Mobile Notifications"
      subtitle="Get notified when something happens"
    />
    <NotificationCard
      heading="Desktop Notifications"
      subtitle="Get notified when something happens"
    />
    <NotificationCard
      heading="Email Notifications"
      subtitle="Get notified when something happens"
    />
  </div>
</template>
