$(document).ready ->

  $(".notification-box").click ->
    $('#com-connect-box').hide()
    $('#com-comments-box').show()

  $('#collapseMessages .row, #com-requests .row').click ->
    $('#com-comments-box').hide()
    $('#com-connect-box').show()
