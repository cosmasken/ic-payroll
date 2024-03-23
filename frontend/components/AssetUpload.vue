<script setup></script>
<template>
  <div
    class="flex flex-col w-full rounded-[10px] border border-dashed border-[#7152F3] p-5"
  >
  <slot></slot>
    <div class="w-10 h-10 p-5 justify-center items-center bg-primary-500 rounded-[10px] self-center">
      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="18" viewBox="0 0 16 18" fill="none">
  <path fill-rule="evenodd" clip-rule="evenodd" d="M4.22464 3.5579C3.98056 3.80198 3.98057 4.19771 4.22465 4.44178C4.46872 4.68586 4.86445 4.68586 5.10853 4.44178L7.37489 2.1754L7.37489 12.3332C7.37489 12.6784 7.65471 12.9582 7.99989 12.9582C8.34507 12.9582 8.62489 12.6784 8.62489 12.3332L8.62489 2.17538L10.8913 4.44178C11.1354 4.68586 11.5311 4.68586 11.7752 4.44178C12.0193 4.1977 12.0193 3.80197 11.7752 3.5579L8.44183 0.22456C8.32462 0.10735 8.16565 0.0415031 7.99989 0.0415039C7.83412 0.0415047 7.67515 0.107354 7.55794 0.224564L4.22464 3.5579ZM3.28309 6.89078C3.49899 6.62146 3.45568 6.22811 3.18636 6.01221C2.91703 5.79631 2.52368 5.83962 2.30778 6.10894C1.30718 7.35716 0.708252 8.94275 0.708252 10.6665C0.708252 14.6936 3.97284 17.9582 7.99992 17.9582C12.027 17.9582 15.2916 14.6936 15.2916 10.6665C15.2916 8.94275 14.6927 7.35716 13.6921 6.10894C13.4762 5.83962 13.0828 5.79631 12.8135 6.01221C12.5442 6.22811 12.5008 6.62146 12.7167 6.89078C13.546 7.92523 14.0416 9.23714 14.0416 10.6665C14.0416 14.0032 11.3366 16.7082 7.99992 16.7082C4.6632 16.7082 1.95825 14.0032 1.95825 10.6665C1.95825 9.23714 2.45385 7.92523 3.28309 6.89078Z" fill="white"/>
</svg>
    </div>
    <div class="flex flex-col items-center">
      <p
        class="text-base font-light text-textcolor dark:text-white leading-[22px]"
      >
        Drag & Drop or
        <span class="text-[@7152F3]"> choose file </span> to upload
      </p>
      <p class="font-light text-accentgray text-[11px] leading-[16px]">
        Supported formats : Jpeg, pdf
      </p>
    </div>
  </div>
</template>
