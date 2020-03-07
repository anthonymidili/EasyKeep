/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Rails setup.
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Foundation setup.
import Foundation from 'foundation-sites'
$(document).on('turbolinks:load', function() {
  $(document).foundation()
});

// jQuery ui setup.
import Autocomplete from 'webpack-jquery-ui/autocomplete'

import Highcharts from 'highcharts'
window.Highcharts = Highcharts

// Flatpickr setup.
import Flatpickr from "flatpickr"

// Custom JavaScripts.
import 'packs/autocomplete'
import 'packs/datePicker'
import 'packs/forms'
import 'packs/moneyBarGraph'
import 'packs/moneyHealth'
import 'packs/moneyLineGraph'
import 'packs/payments'

// Custom stylesheets.
import 'src/application'

// images and fonts.
require.context('../images', true)

// fontawesome setup.
import '@fortawesome/fontawesome-free/js/all'
import '@fortawesome/fontawesome-free/css/all'

// cocoon js setup.
import "cocoon-js"
