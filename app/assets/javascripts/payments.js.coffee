jQuery ->
  $(document).on 'click', (e) ->
    # Remove payments/_form partial from account show page.
    $('.applyPaymentTR').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
        $('tr').removeClass('active_row')

    # Remove payments/_new partial from invoice show page and replace apply payment link.
    $('#newPaymentForm').each ->
      if $(e.target).closest(this).length == 0
        $(this).remove()
        $('a[id^="applyPaymentLink"]').show()
