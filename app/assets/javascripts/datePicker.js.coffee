jQuery ->
  $('body').on 'focus', '.datePicker', ->
    $('.datePicker').each ->
      $(this).pickadate
        selectYears: true
        selectMonths: true
        format: 'yyyy-mm-dd'
