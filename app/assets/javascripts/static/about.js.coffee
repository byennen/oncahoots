$(document).ready ->
  $(".selectyze2").Selectyze theme: "mac"
  $("#selector").gentleSelect() # apply gentleSelect with default options
  $("#selector2").gentleSelect() # apply gentleSelect with default options
  $("#hidShow").click ->
    if $(".sub-com").css("display") is "block"
      $(".sub-com").css "display", "none"
    else
      $(".sub-com").css "display", "block"

  $(".hid").on "click", ->
    $(this).hide()
    $(".showa").show()
