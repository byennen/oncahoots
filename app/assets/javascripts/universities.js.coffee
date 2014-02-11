# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  backgroundImage = $("a.university-most-popular-club-action").attr('data-background-image')
  $(".university-most-popular-club").css("background", "url('#{backgroundImage}') no-repeat center center")

  $(document).on 'change', '#metropolitan_club_city_selector', (event) ->
    document.location = document.location + "/clubs/" + $(event.target).val()

  $("#user_city_id").gentleSelect() # apply gentleSelect with default options
  $("#user_university_id").gentleSelect() # apply gentleSelect with default options
  $("#user_graduation_year").gentleSelect() # apply gentleSelect with default options
  $("#user_professional_field_id").gentleSelect() # apply gentleSelect with default options
