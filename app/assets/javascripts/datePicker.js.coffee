jQuery ->
  $('body').on 'focus', '.datePicker:not(.hasDatepicker)', ->
    $('.datePicker').each ->
      $(this).pickadate
        selectYears: true
        selectMonths: true
        format: 'yyyy-mm-dd'
        today: 'Today'
        clear: 'Clear selection'
        close: 'Cancel'

  $(document).on 'click', (e) ->
    $('.applyPaymentTR').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
