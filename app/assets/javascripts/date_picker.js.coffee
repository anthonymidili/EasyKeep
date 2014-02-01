jQuery ->
  $('body').on 'focus', '.datePicker:not(.hasDatepicker)', ->
    $(this).datepicker
      changeYear: true
      changeMonth: true
      dateFormat: 'yy-mm-dd'