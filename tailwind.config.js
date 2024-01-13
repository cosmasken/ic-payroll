/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./frontend/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {

      fontFamily: {
        lexend: ['Lexend', 'sans-serif'],
    },
    },
  },
  plugins: [],
}

