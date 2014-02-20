$ ->
  $(document).on 'click', ".events-list .event", ->
    document.location = $(this).data()['url']