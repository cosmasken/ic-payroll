<template>
  <div class="number-picker">
    <input
      type="text"
      v-model="inputValue"
      @input="validateNumber"
      class="block w-full p-2 border rounded-md shadow-sm sm:text-sm focus:ring-indigo-500 focus:border-indigo-500"
      placeholder="Enter a positive integer"
    />
    <p v-if="!isValid && inputValue !== ''" class="mt-2 text-sm text-red-600">
      Please enter a valid positive integer.
    </p>
  </div>
</template>

<script setup>
import { ref, watch } from "vue";

// Props
const props = defineProps({
  modelValue: [String, Number],
});

// Emits
const emit = defineEmits(["update:modelValue"]);

const inputValue = ref(props.modelValue);
const isValid = ref(true);

watch(inputValue, (newVal) => {
  validateNumber();
});

function validateNumber() {
  const parsedNumber = parseInt(inputValue.value, 10);
  isValid.value =
    !isNaN(parsedNumber) && parsedNumber > 0 && Number.isInteger(parsedNumber);
  if (isValid.value) {
    emit("update:modelValue", parsedNumber);
  } else {
    emit("update:modelValue", "");
  }
}
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>
