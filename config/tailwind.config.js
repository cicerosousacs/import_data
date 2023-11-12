const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    // './public/*.html',
    // './app/helpers/**/*.rb',
    // './app/javascript/**/*.js',
    // './app/views/**/*.{erb,haml,html,slim}'
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
// module.exports = {
//   plugins: [require("@tailwindcss/typography")],
//   themes: ["emerald"],
//   content: [
//     './app/views/**/*.html.erb',
//     './app/helpers/**/*.rb',
//     './app/assets/stylesheets/**/*.css',
//     './app/javascript/**/*.js'
//   ]
// }