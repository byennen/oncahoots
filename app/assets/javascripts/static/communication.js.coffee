$(document).ready ->
  $(".selectyze2").Selectyze theme: "mac"
  $("ul").accordion()
  $(".lala").on "click", ->
    $(".lal").hide()
    $(".showass").show()

  $(".lalas").on "click", ->
    $(".showass").hide()
    $(".lal").show()

  $("#mes").click ->
    if $("#uni").css("display") is "none"
      $("#uni").css "display", "block"
    else
      $("#uni").css "display", "none"
