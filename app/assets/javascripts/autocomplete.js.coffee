jQuery ->
  $('#account_name').autocomplete
    source: $('#account_name').data('autocomplete-source')
