$(document).ready ->
  $(document).on 'click', '.admin-action .unadminister', (event) ->
    $(this).closest('.admin-action').hide()
  $(document).on 'click', '.trigger-admin-action', (event) ->
    currentAdminAction = $(this).closest('li').find('.admin-action')
    $('.admin-action').each ->
      if this == currentAdminAction[0]
        $(this).fadeIn('fast')
      else
        $(this).fadeOut('fast')