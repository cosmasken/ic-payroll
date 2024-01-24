<script setup>
import { ref } from "vue";
import { Switch } from "@headlessui/vue";

const enabled = ref(false);
defineProps({
  heading: String,
  subtitle: String,
  active: Boolean,
});
</script>
<template>
  <div class="flex flex-row justify-between">
    <div class="flex flex-col">
      <p>
        {{ heading }}
      </p>
      <p>
        {{ subtitle }}
      </p>
    </div>
    <Switch
      v-model="enabled"
      :class="[
        enabled ? 'bg-indigo-600' : 'bg-gray-200',
        'relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-indigo-600 focus:ring-offset-2',
      ]"
    >
      <span class="sr-only">Use setting</span>
      <span
        aria-hidden="true"
        :class="[
          enabled ? 'translate-x-5' : 'translate-x-0',
          'pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out',
        ]"
      />
    </Switch>
  </div>
</template>
