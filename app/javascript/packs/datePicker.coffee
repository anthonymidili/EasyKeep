document.addEventListener 'turbolinks:load', ->
  # Flatpickr date picker standard options
  dateOptions =
    altInput: true
    altFormat: 'F j, Y'
    dateFormat: 'Y-m-d'

  # Flatpickr date picker.
  flatpickr '.datePicker', dateOptions

  # Add flatpickr date picker to cocoon generated objects.
  $('#services').on 'cocoon:after-insert', ->
    $('#services').find('.datePicker:last').flatpickr dateOptions
    return
