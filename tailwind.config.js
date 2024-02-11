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
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      "light",
      "dark",
      "cupcake",
      "bumblebee",
      "emerald",
      "corporate",
      "synthwave",
      "retro",
      "cyberpunk",
      "valentine",
      "halloween",
      "garden",
      "forest",
      "aqua",
      "lofi",
      "pastel",
      "fantasy",
      "wireframe",
      "black",
      "luxury",
      "dracula",
      "cmyk",
      "autumn",
      "business",
      "acid",
      "lemonade",
      "night",
      "coffee",
      "winter",
      "dim",
      "nord",
      "sunset",
    ],
     // false: only light + dark | true: all themes | array: specific themes like this ["light", "dark", "cupcake"]
    darkTheme: "dark", // name of one of the included themes for dark mode
    base: true, // applies background color and foreground color for root element by default
    styled: true, // include daisyUI colors and design decisions for all components
    utils: true, // adds responsive and modifier utility classes
    prefix: "", // prefix for daisyUI classnames (components, modifiers and responsive class names. Not colors)
    logs: true, // Shows info about daisyUI version and used config in the console when building your CSS
    themeRoot: ":root", // The element that receives theme color CSS variables
  },

}

