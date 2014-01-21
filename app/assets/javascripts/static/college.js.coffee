$(document).ready ->
  $(".selectyze2").Selectyze theme: "mac"
  $(".nsw").on "click", ->
    $(".showaa").hide()
    $(".hid").show()


$(window).load ->
  $("#flexiselDemo1").flexisel
    enableResponsiveBreakpoints: true
    responsiveBreakpoints:
      portrait:
        changePoint: 480
        visibleItems: 1

      landscape:
        changePoint: 640
        visibleItems: 2

      tablet:
        changePoint: 768
        visibleItems: 3
