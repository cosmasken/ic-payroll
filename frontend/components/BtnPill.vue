<template>
  <div>
    <button
      :style="{ backgroundColor: bgColor || 'transparent' }"
      class="py-1 px-4 rounded-lg border flex flex-row items-center space-x-2 border-[#F2F8FF] text-[#1C3680]"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        width="16"
        height="16"
        viewBox="0 0 16 16"
        fill="none"
      >
        <path
          d="M13.3437 4.66669H3.41659C3.18638 4.66669 2.99992 4.48023 2.99992 4.25002C2.99992 4.01981 3.18638 3.83335 3.41659 3.83335H13.4166C13.6468 3.83335 13.8333 3.6469 13.8333 3.41669C13.8333 2.72632 13.2736 2.16669 12.5833 2.16669H2.99992C2.07935 2.16669 1.33325 2.91278 1.33325 3.83335V12.1667C1.33325 13.0873 2.07935 13.8334 2.99992 13.8334H13.3437C14.0734 13.8334 14.6666 13.2727 14.6666 12.5834V5.91669C14.6666 5.22736 14.0734 4.66669 13.3437 4.66669ZM12.1666 10.0834C11.7064 10.0834 11.3333 9.71018 11.3333 9.25002C11.3333 8.78986 11.7064 8.41669 12.1666 8.41669C12.6267 8.41669 12.9999 8.78986 12.9999 9.25002C12.9999 9.71018 12.6267 10.0834 12.1666 10.0834Z"
          fill="#4C98FF"
        />
      </svg>
      <span :style="{ color: textcolor}" >
        {{ props.text }}
      </span>
    </button>
  </div>
</template>
<script setup>
const props = defineProps(['text', 'bgColor', 'textcolor'])
</script>
