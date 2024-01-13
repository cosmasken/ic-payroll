<script setup lang="ts">
import { ref } from "vue"

const step = ref(0)
const props = defineProps<{
  steps: string[]
}>()
const count = ref(0)
</script>

<template>
  <template>
    <div class="w-6/12">
      <ul class="steps min-w-full">
        <li
          v-for="(stepText, index) in props.steps"
          class="step"
          :class="index <= step ? 'step-primary' : ''"
        >
          {{ stepText }}
        </li>
      </ul>
    </div>
  </template>
</template>

<style scoped>
.read-the-docs {
  color: #888;
}
</style>
