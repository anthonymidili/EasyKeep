document.addEventListener 'turbolinks:load', ->
  textBox = $('#account_name')
  nameAray = textBox.data('autocomplete-source')
  accountFields = $('.newAccountFields.hidden')

  # jQuery-ui autocomplete data source.
  textBox.autocomplete source: nameAray

  # Event to check if autocomplete drop down is clicked.
  $('ul.ui-autocomplete').click ->
    checkValue()

  # Account name text box. Event to check if text box changes in any way.
  textBox.on 'propertychange change keyup paste input', ->
    checkValue()

  # Checks if value in account text box is in autocomplete data source.
  # If so, hide new account attributes.
  checkValue = ->
    inputText = document.getElementById('account_name').value
    if $.inArray(inputText, nameAray) != -1
      accountFields.hide()
    else
      accountFields.show()

  $('#toggle').click ->
    accountFields.toggle()
