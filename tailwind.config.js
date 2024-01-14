/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    "./index.html",
    "./frontend/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {

      fontFamily: {
        lexend: ['Lexend', 'sans-serif'],
    },
    colors: {
      'backdrop': '#F5F6FA',
      'textcolor': '#16151C',
      'darktextcolor' : '#FFFFFF',
      'accentgray' : '#A2A1A8',
      'bordercolor' : '#A2A1A833',
      'earlyTextColor':'#3FC28A',
      'lateTextColor':'#F45B69',
      'earlyBgColor':'#3FC28A1A',
      'lateBgColor':'#F45B691A',
      // for page background color
      'primary': { // primary theme color
          DEFAULT: '#092443',
          '50': '#E6E8FB',
          '100': '#0819D7',
          '200': '#0C192D',
          '300': '#062D10',
          '400': '#475467',
          '500': '#0A1242',
          '600': '#101828',
          '700': '#00D084B2',
          '800': '#EEF7FC',
          '900': '#000000'
      },
      // 'accent': colors.blue, // secondary theme color
      // 'warning': colors.amber, // for warning messages, statuses etc
      // 'success': colors.green, // for success messages, statuses etc
      // 'alert': colors.red, // for error messages, statuses etc
      // 'info': colors.blue, // for info messages, links etc
  },
    },
  },
  plugins: [],
}

