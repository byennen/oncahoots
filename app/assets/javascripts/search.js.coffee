# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.dropdown input[type=text]').attr('readonly', true);
  $(document).on 'click', '.dropdown-menu li a', ->
    $(this).closest(".dropdown").find("input").val($(this).text())