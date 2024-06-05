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
      "autom8-blue": {
        50: "#EEF3FC",
        100: "#D8E3F8",
        200: "#B5CBF2",
        300: "#8EAFEB",
        400: "#6793E4",
        500: "#4379DE",
        600: "#225BC3",
        700: "#1A4493",
        800: "#122E64",
        900: "#081630",
        950: "#050C1A"
    },
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
      
          '100': '#E6E2F8',
          '200': '#CEC4F6',
          '300': '#B2A2F9',
          '400': '#9178FA',
          '500': '#7152F3',
          '600': '#5D3DE7',
          '700': '#4F31D0',
          '800': '#3517B4',
          '900': '#250C92'
      },
      'secondary': { // secondary theme color
      
        '100': '#E1F1BC',
        '200': '#CEE993',
        '300': '#BCDE6B',
        '400': '#AFD751',
        '500': '#A3D139',
        '600': '#97BD33',
        '700': '#88A52A',
        '800': '#798D21',
        '900': '#626615'
    },
    'tertiary': { // tertiary theme color
      
      '100': '#F0B0D9',
      '200': '#E67BC2',
      '300': '#D846AB',
      '400': '#CD0D9B',
      '500': '#B21589',
      '600': '#AF0A87',
      '700': '#9B0982',
      '800': '#8A087C',
      '900': '#6C0772'
  },


'dark': { // tertiary theme color
      
  '5%': '#16151C0D',
  '10%': '#16151C1A',
  '20%': '#16151C33',
  '80%': '#16151CCC',
  '90%': '#16151CE5',
  '500': '#16151C'
},
'gray': { // tertiary theme color
      
  '5%': '#A2A1A80D',
  '10%': '#A2A1A81A',
  '20%': '#A2A1A833',
  '80%': '#A2A1A8CC',
  '90%': '#A2A1A8E5',
  '500': '#A2A1A8'
},
'light': { // tertiary theme color
      
  '5%': '#D9E1E10D',
  '10%': '#D9E1E11A',
  '20%': '#D9E1E133',
  '80%': '#D9E1E1CC',
  '90%': '#D9E1E1E5',
  '500': '#D9E1E1'
},
'white': { // tertiary theme color
      
  '5%': '#FFFFFF0D',
  '10%': '#FFFFFF1A',
  '20%': '#FFFFFF33',
  '80%': '#FFFFFFCC',
  '90%': '#FFFFFFE5',
  '500': '#FFFFFF'
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

