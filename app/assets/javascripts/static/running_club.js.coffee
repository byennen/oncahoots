$(document).ready ->
  $(".selectyze2").Selectyze theme: "mac"
  $("#selector").gentleSelect() # apply gentleSelect with default options
  $("#selector2").gentleSelect() # apply gentleSelect with default options
  $("#nsw").on "click", ->
    $(".showa").hide()
    $(".hid").show()
