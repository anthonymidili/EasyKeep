jQuery ->
  $('body').on 'focus', '.datePicker:not(.hasDatepicker)', ->
    $('.datePicker').each ->
      $(this).datepicker
        changeYear: true
        changeMonth: true
        dateFormat: 'yy-mm-dd'
        altField: $("[id^='datePicker']")

  $(document).on 'click', (e) ->
    $('.applyPaymentTR').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
