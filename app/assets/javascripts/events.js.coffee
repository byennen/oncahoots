$(document).ready ->
  $("#datepicker").datepicker inline: true
  $(".selectyze2").Selectyze theme: "mac"
  $(".nna").on "click", ->
    $(".events-list").hide()
    $(".mon").show()
    $(".di").css "color", "#00D689"

  $(".nnaa").on "click", ->
    $(".mon").hide()
    $(".events-list").show()
    $(".di").css "color", "#00D689"

  $(".nnaa5").on "click", ->
    $(".mon").hide()
    $(".mon22").show()
    $(".di").css "color", "#00D689"

  $(".nnaa5").on "click", ->
    $(".events-list").hide()
    $(".mon22").show()
    $(".di").css "color", "#00D689"

  $(".nna").on "click", ->
    $(".mon22").hide()
    $(".mon").show()
    $(".di").css "color", "#00D689"

  $("#selector").gentleSelect()
  $("#selector2").gentleSelect()
  $("#selector3").gentleSelect()
  $("#selector4").gentleSelect()
  $("#selector5").gentleSelect()
  $("#selector6").gentleSelect()
  $("#selector7").gentleSelect()
