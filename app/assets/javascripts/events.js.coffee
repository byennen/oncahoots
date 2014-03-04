$(document).on "ready page:load", ->
  $("#event_on_date").datepicker inline: true
  $("#weekly-events-calendar").datepicker inline: true

  $("#monthly-events-calendar").datepicker
    inline: true
    dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
    onSelect: (dateText, inst) ->
      day = $(this).datepicker("getDate").getDate()
      month = $("#monthly-events-calendar").datepicker("getDate").getMonth() + 1
      if month.size = 1
        month = "0" + month
      year = $("#monthly-events-calendar").datepicker("getDate").getFullYear().toString();
      shortenedYear = year.substring(2, 4)
      console.log "Month is: " + month + " day is " + day + " year is " + year
      $.ajax
        type: "GET"
        dataType: 'script'
        url: "events/?date="+month+shortenedYear
        success: (response) ->
          $("#monthly-events-calendar").datepicker()
      return

  $('#monthly-events-calendar').find('.ui-datepicker-header').remove();

  $("#plus_month").on "click", ->
    alert "hello"
    month = $("#monthly-events-calendar").datepicker("getDate").getMonth()
    alert month
    $('#monthly-events-calendar').datepicker("setDate", month + 'm');

#  $("#monthly-events-calendar").on "click", ->
#    day = $("#monthly-events-calendar").datepicker("getDate").getDay()
#    month = $("#monthly-events-calendar").datepicker("getDate").getMonth() + 1
#    if month.size = 1
#      month = "0" + month
#    year = $("#monthly-events-calendar").datepicker("getDate").getFullYear().toString();
#    shortenedYear = year.substring(2, 4)
#    $.ajax
#      type: "GET"
#      dataType: 'script'
#      url: "events/?date="+month+shortenedYear
#      success: (response) ->
#        $("#monthly-events-calendar").datepicker()
#        return
#    return

  $(".free_food").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").hide()
    $("#events-list").show()
    $("#event-detail").hide()

  $(".weekly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#monthly-events-calendar").hide()
    $("#event-area-monthly-listing").hide()
    $("#weekly-events-calendar").show()
    $("#event-detail").hide()

  $(".monthly").on "click", ->
    $(".session a").removeClass('current')
    $(@).addClass('current')
    $("#weekly-events-calendar").hide()
    $("#monthly-events-calendar").show()
    $("#event-area-monthly-listing").show()
    $(".monthly-event-listing").hide()

  # hide monthly calendar on initial load
  $("#monthly-events-calendar").hide()
  $("#weekly-events-calendar").hide();
  $("#event-area-monthly-listing").hide()
  $("#event-detail").hide()

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

  selectedEventId = $('#selected_event_id').val()
  $('.event-listing.event-item[data-id='+selectedEventId+']').click()
