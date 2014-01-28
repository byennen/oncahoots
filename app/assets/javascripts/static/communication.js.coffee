$(document).ready ->

  $(".notification-box").click ->
    $('#com-connect-box').hide()
    $('#com-comments-box').show()

  $('#collapseMessages .row, #collapseRequests .row').click ->
    $('#com-comments-box').hide()
    $('#com-connect-box').show()
