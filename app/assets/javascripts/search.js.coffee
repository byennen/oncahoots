# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.dropdown input[type=text]').attr('readonly', true);
  $(document).on 'click', '.dropdown-menu li a', ->
    $(this).closest(".dropdown").find("input").val($(this).text())
  $(".search_type a").click ->
    if $(this).text() == 'Person'
      $("#club-option").hide()
      $("#club-title").hide()
      $("#person-option").show()
      $("#person-title").show()
      $(".search_club").hide()
    else
      $("#person-option").hide()
      $("#person-title").hide()
      $("#club-option").show()
      $("#club-title").show()
      $(".search_club").show()

  $("#search-button").click ->
    data = {}
    obj = $("input#search_object").val()
    data['name'] = $("input#name").val()
    if obj=="Person"
      data['loc'] = $("input#location").val()
      data['type']= $("input#ptype").val()
      data['major']= $("input#major").val()
      data['year']= $("input#graduation_year").val()
      $.get("/search/person", user: data)
    else if obj=="Club"
      data['category']=$("#category").val()
      $.get("/search/club", club: data)
  $("#search-contact").click ->
    data = {}
    data['name'] = $("input#name").val()
    data['loc'] = $("input#location").val()
    data['type']= $("input#ptype").val()
    data['major']= $("input#major").val()
    data['year']= $("input#graduation_year").val()
    $.get("/users/1/contacts/multi_search", user: data)


  $(".search_all #search_field").keydown (e) ->
    if e.keyCode == 13
      window.location.href="/search?term=#{$(this).val()}"
  $(".search_all #search-btn").click ->
      window.location.href="/search?term=#{$("#search_field").val()}"
