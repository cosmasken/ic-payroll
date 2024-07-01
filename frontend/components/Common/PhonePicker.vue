<template>
    <div class="phone-picker">
      <div class="flex items-center space-x-2">
        <select
          v-model="selectedCountry"
          class="block w-24 p-2 bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
        >
          <option v-for="country in countries" :key="country.code" :value="country.dial_code">
            {{ country.flag }} {{ country.dial_code }}
          </option>
        </select>
        <input
          type="tel"
          v-model="phoneNumber"
          class="block w-full p-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          placeholder="Phone number"
          @input="emitPhoneNumber"
        />
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref } from 'vue';
  
  const countries = [
    { name: 'Kenya', code: 'KE', dial_code: '+254', flag: '🇰🇪' },
    { name: 'Uganda', code: 'UG', dial_code: '+256', flag: '🇺🇬' },
    { name: 'Tanzania', code: 'TZ', dial_code: '+255', flag: '🇹🇿' },
    { name: 'Rwanda', code: 'RW', dial_code: '+250', flag: '🇷🇼' },
    { name: 'Burundi', code: 'BI', dial_code: '+257', flag: '🇧🇮' },
    { name: 'South Sudan', code: 'SS', dial_code: '+211', flag: '🇸🇸' },
  ];
  
  const selectedCountry = ref(countries[0].dial_code);
  const phoneNumber = ref('');
  
  function emitPhoneNumber() {
    const fullNumber = `${selectedCountry.value}${phoneNumber.value}`;
    // Emit the full phone number, you can also validate or format it here
    console.log(fullNumber);
  }
  </script>
  
  <style scoped>
  /* Add any scoped styles if necessary */
  </style>
  