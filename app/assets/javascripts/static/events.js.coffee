$(document).ready ->
  $("#datepicker").datepicker inline: true

  $("#category-select").gentleSelect()
  $("#time-ampm-select").gentleSelect()
  $("#time-minute-select").gentleSelect()
  $("#time-hour-select").gentleSelect()
  $("#club-event-select").gentleSelect()
  $("#club-select").gentleSelect()
  $("#free-food-select").gentleSelect()

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
