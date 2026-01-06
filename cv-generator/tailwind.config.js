/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./layouts/**/*.html",
    "./content/**/*.md",
    "./themes/**/layouts/**/*.html",
    "./themes/**/content/**/*.md",
    "./static/**/*.js"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
