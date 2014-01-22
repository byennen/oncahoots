$(document).ready ->
  $("#datepicker").datepicker inline: true
  $(".selectyze2").Selectyze theme: "mac"

  $("#selector").gentleSelect()
  $("#selector2").gentleSelect()
  $("#selector3").gentleSelect()
  $("#selector4").gentleSelect()
  $("#selector5").gentleSelect()
  $("#selector6").gentleSelect()
  $("#selector7").gentleSelect()

  $(".freefood").on "click", ->
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#events-list").show()
    $("#event-area-single").show()

  $(".weekly").on "click", ->
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#events-list").show()
    $("#event-area-single").show()

  $(".monthly").on "click", ->
    $("#events-list").hide()
    $("#event-area-single").hide()
    $("#monthly-events-calendar").show()
    $("#event-area-monthly-listing").show()

  # hide monthly calendar on initial load
  $("#monthly-events-calendar").hide()
  $("#event-area-monthly-listing").hide()
