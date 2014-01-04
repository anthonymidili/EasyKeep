jQuery ->
  $("#view_by_selection input[type='submit']").hide()
  $("#view_by_selection input[type='radio']").click ->
    $(this).closest("form").submit()
