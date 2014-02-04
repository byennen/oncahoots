# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  backgroundImage = $("a.university-most-popular-club-action").attr('data-background-image')
  $(".university-most-popular-club").css("background", "url('#{backgroundImage}') no-repeat center center")

  $(".new_user select").gentleSelect()
