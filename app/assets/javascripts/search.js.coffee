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
      $("#person-option").show()
    else
      $("#person-option").hide()
      $("#club-option").show()

  $("#search-button").click ->
    data = {}
    obj = $("input#search_object").val()
    data['name'] = $("input#name").val()
    data['loc'] = $("input#location").val
    if obj=="Person"
      data['ptype']= $("input#ptype").val()
      data['major']= $("input#major").val()
      data['graduaration_year']= $("input#graduaration_year").val()
      $.get("/search/person", user: data)
    else if obj=="Club"
      data['category']=$("#category").val()
      $.get("/search/club", club: data)
