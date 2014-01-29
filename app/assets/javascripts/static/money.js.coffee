$(document).ready ->

  $("#money select").each ->
    $(this).gentleSelect()


  $(".hid").on "click", ->
    $(this).hide()
    $(".showa").show()

  $("#nsw").on "click", ->
    $(".showa").hide()
    $(".hid").show()
