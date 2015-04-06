jQuery ->
  $('body').on 'focus', '.datePicker', ->
    $('.datePicker').each ->
      $(this).pickadate
        selectYears: true
        selectMonths: true
        format: 'yyyy-mm-dd'

  $(document).on 'click', (e) ->
    $('.applyPaymentTR').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
        $('tr').removeClass('active_row')
