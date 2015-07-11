jQuery ->
  # /invoices/_change_account_header.html.haml
  $("#change_account_header input[type='submit']").hide()
  $("#change_account_header input[type='checkbox']").change ->
    $(this).closest("form").submit()

  # /services/_date_bar_forms.html.haml
  # /reports/_report_for_form.html.haml
  $("#view_by_selection input[type='submit']").hide()
  $("#view_by_selection input[type='radio']").click ->
    $(this).closest("form").submit()
