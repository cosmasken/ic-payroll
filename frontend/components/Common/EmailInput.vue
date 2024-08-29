<template>
  <div class="email-input w-full">
    <input
      type="email"
      v-model="email"
      :class="[
        'block w-full p-2 border rounded-md shadow-sm sm:text-sm',
        isValid
          ? 'border-gray-300 focus:ring-indigo-500 focus:border-indigo-500'
          : 'border-red-500 focus:ring-red-500 focus:border-red-500',
      ]"
      placeholder="Email address"
      @input="validateEmail"
    />
    <p v-if="!isValid && email" class="mt-2 text-sm text-red-600">
      Please enter a valid email address.
    </p>
  </div>
</template>

<script setup>
import { ref } from "vue";

// Props
const props = defineProps({
  modelValue: String,
});

// Emits
const emit = defineEmits(["update:modelValue"]);

const email = ref(props.modelValue);
const isValid = ref(true);

function validateEmail() {
  const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  isValid.value = emailPattern.test(email.value);
  emit("update:modelValue", email.value);
}
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>
