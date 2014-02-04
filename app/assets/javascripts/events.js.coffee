$(document).ready ->
  $("#datepicker").datepicker inline: true

  $(".free_food").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").hide()
    $("#events-list").show()
    $("#event-detail").show()

  $(".weekly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").show()
    $("#event-detail").show()

  $(".monthly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#event-detail").hide()
    $("#weekly-events-calendar").hide()
    $("#monthly-events-calendar").show()
    $("#event-area-monthly-listing").show()

  # hide monthly calendar on initial load
  $("#monthly-events-calendar").hide()
  $("#event-area-monthly-listing").hide()
  $("#weekly-events-calendar").show()


  $("#new-event-link").click() if $("#error").text() is "t"

  $(document).on "click", ".event-item", ->
    $(".event-display").addClass "hide"
    $("#event-show" + $(this).data("id")).removeClass "hide"
    $("#event-area-monthly-listing").hide()
    $("#event-detail").show()

  $(document).on "click", ".next-event", ->
    $(".event-display").addClass "hide"
    $("#event-show" + $(this).data("id")).removeClass "hide"

  $(document).on "click", ".back", ->
    $(".event-display").addClass "hide"
    $("#event-area-monthly-listing").show()


  # clicking event from monthly list
  $('#event-area-monthly-listing table tr').on "click", ->
    $("#event-detail").show()
    $("#event-area-monthly-listing").hide()




  # ADD NEW EVENT FORM
  $("#category-select select").gentleSelect()
  $("#time-ampm-select select").gentleSelect()
  $("#time-minute-select select").gentleSelect({rows: 10, itemWidth: 60})
  $("#time-hour-select select").gentleSelect({rows: 6, itemWidth: 24})
  $("#club-event-select select").gentleSelect()
  $("#club-select select").gentleSelect()
  $("#free-food-select select").gentleSelect()
  $("#event_at_time_4i, #event_at_time_5i").addClass("col-md-6 no-padding")
  $("#event_at_time_4i").gentleSelect({rows: 6, itemWidth: 24})
  $("#event_at_time_5i").gentleSelect({rows: 10, itemWidth: 60})

  # Hide "select club" dropdown unless club event is "yes"
  $('#club-select').hide()
  $('#club-event-select select').on 'change', (e) ->
    if $('#club-event-select li.selected').html() == "Yes"
      $('#club-select').show()
    else
      $('#club-select').hide()

