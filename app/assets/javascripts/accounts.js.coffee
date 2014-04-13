jQuery ->
  $("#change_account_header input[type='submit']").hide()
  $("#change_account_header input[type='checkbox']").change ->
    $(this).closest("form").submit()
