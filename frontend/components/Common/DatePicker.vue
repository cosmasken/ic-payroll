<template>
  <div class="date-picker">
    <input
      type="date"
      v-model="date"
      class="block w-full p-2 border rounded-md shadow-sm sm:text-sm focus:ring-indigo-500 focus:border-indigo-500"
      @input="emitDate"
    />
    <p v-if="date" class="mt-2 text-sm text-gray-700">
      Selected Date: {{ formattedDate }}
    </p>
  </div>
</template>

<script setup>
import { ref, computed } from "vue";

// Props
const props = defineProps({
  modelValue: String,
});

// Emits
const emit = defineEmits(["update:modelValue"]);

const date = ref(props.modelValue);

const formattedDate = computed(() => {
  if (!date.value) return "";
  const options = { year: "numeric", month: "long", day: "numeric" };
  return new Date(date.value).toLocaleDateString(undefined, options);
});

function emitDate() {
  emit("update:modelValue", date.value);
}
</script>

<style scoped>
/* Add any scoped styles if necessary */
</style>
