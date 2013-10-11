# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
split = (val) ->
  val.split /,\s*/

extractLast = (term) ->
  split(term).pop()

$(document).on 'ready page:load', -> 
  $('.tagauto').tagsInput({
    width:'530px', 
    height: "35px",
    defaultText: 'add recipients',
    autocomplete_url: "/users/search",
  });
$ ->

  #recipients = $('#message_recipients').data('autocomplete-source')

  # don't navigate away from the field on tab when selecting an item
  # $('#message_recipients').bind "keydown", (event) ->
  #   if event.keyCode == $.ui.keyCode.TAB and $(@).data("autocomplete").menu.active then event.preventDefault()
  # $('#message_recipients').autocomplete
  #     minLength: 0
  #     source: (request, response) ->
  #       # delegate back to autocomplete, but extract the last term
  #       recipients = $('#message_recipients').data('autocomplete-source')
  #       response $.ui.autocomplete.filter(recipients, extractLast(request.term))
  #     focus: -> return false # prevent last value inserted on focus
  #     select: (event, ui) ->
  #       terms = split(@value)
  #       # remove the current input
  #       terms.pop()
  #       # add the selected item
  #       terms.push ui.item.value
  #       # add placeholder to get the comma-and-space at the end
  #       terms.push ""
  #       @value = terms.join ", "
  #       return false

  $('#delete_multiple_button').hide()
  $('.delete_multiple_checkbox').click -> $('#delete_multiple_button').fadeIn()
  
  $("#new-message").click (event) ->
    $("#current_conversation").hide();
    $("#conversation_reply").hide();
    $("#new_conversation").show()
