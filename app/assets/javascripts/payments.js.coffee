jQuery ->
  $(document).on 'click', (e) ->
    # Remove payments/_new partial from invoice show page and show apply payment link.
    $('#newPaymentForm').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
        $('[id^="applyPaymentLink"]').show()

    # Remove payments/_form partial from account show page.
    $('.applyPaymentTR').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
        $('tr').removeClass('active_row')
