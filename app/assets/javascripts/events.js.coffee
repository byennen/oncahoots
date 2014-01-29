$(document).ready ->
  $("#datepicker").datepicker inline: true

  $(".freefood").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").hide()
    #$("#events-list").show()
    $("#event-area-single").show()

  $(".weekly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").show()
    $("#event-area-single").show()

  $(".monthly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#event-area-single").hide()
    $("#weekly-events-calendar").hide()
    $("#monthly-events-calendar").show()
    $("#event-area-monthly-listing").show()

  # hide monthly calendar on initial load
  $("#monthly-events-calendar").hide()
  $("#event-area-monthly-listing").hide()
  $("#weekly-events-calendar").hide()

  $('#monthly-events-calendar .event-listing').on "click", ->
    $("#monthly-events-calendar").hide()
    #$("#event-area-monthly-listing").hide()
    #$("#event-area-single").show()
    $("#weekly-events-calendar").show()



  # clicking event from monthly list
  $('#event-area-monthly-listing table tr').on "click", ->
    $("#event-area-single").show()
    $("#event-area-monthly-listing").hide()

    # static: change button from "interested" to "back"
    # Should be set based on whether this user is already interested in this event in dynamic views
    #$("#event-area-single button:first-of-type").html("Back")


  # ADD NEW EVENT FORM
  $("#category-select select").gentleSelect()
  $("#time-ampm-select select").gentleSelect()
  $("#time-minute-select select").gentleSelect()
  $("#time-hour-select select").gentleSelect()
  $("#club-event-select select").gentleSelect()
  $("#club-select select").gentleSelect()
  $("#free-food-select select").gentleSelect()
  $("#event_at_time_4i, #event_at_time_5i").addClass("col-md-6 no-padding")
  $("#event_at_time_4i").gentleSelect()
  $("#event_at_time_5i").gentleSelect()

  # Hide "select club" dropdown unless club event is "yes"
  $('#club-select').hide()
  $('#club-event-select select').on 'change', (e) ->
    if $('#club-event-select li.selected').html() == "Yes"
      $('#club-select').show()
    else
      $('#club-select').hide()

