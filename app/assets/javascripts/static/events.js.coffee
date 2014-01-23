$(document).ready ->
  $("#datepicker").datepicker inline: true

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


  # ADD NEW EVENT FORM
  $("#category-select select").gentleSelect()
  $("#time-ampm-select select").gentleSelect()
  $("#time-minute-select select").gentleSelect()
  $("#time-hour-select select").gentleSelect()
  $("#club-event-select select").gentleSelect()
  $("#club-select select").gentleSelect()
  $("#free-food-select select").gentleSelect()

  # Hide "select club" dropdown unless club event is "yes"
  $('#club-select').hide()
  $('#club-event-select select').on 'change', (e) ->
    if $('#club-event-select li.selected').html() == "Yes"
      $('#club-select').show()
    else
      $('#club-select').hide()

