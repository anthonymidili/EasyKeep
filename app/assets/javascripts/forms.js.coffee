jQuery ->
  $(".inline-tiny-button input[type='submit']").css("width", "100%").css "width", "-=30px"
  $(window).on "resize", ->
    $(".inline-tiny-button input[type='submit']").css("width", "100%").css "width", "-=30px"
    return