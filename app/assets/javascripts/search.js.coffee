$(document).ready ->
  $("#club_private").gentleSelect() # apply gentleSelect with default options
  $("#club_category").gentleSelect()
  $("#datepicker").datepicker inline: true
  $("#datepicker2").datepicker inline: true
  $(".selectyze2").Selectyze theme: "mac"
  $(".basic").fancySelect()

  #Default Action
  #$(".tab_content").hide() #Hide all content
#  $("ul.tabsx li:first").addClass("activex").find("a") #Activate first tab
  #$(".tab_content:first").show() #Show first tab content

  #On Click Event
  $("ul.tabsx li").click ->
    $("ul.tabsx li").removeClass "activex" #Remove any "active" class
    $(this).addClass "activex" #Add "active" class to selected tab
    $(".tab_content").addClass("hide")#Hide all tab content
    activeTab = $(this).find("a").attr("href") #Find the rel attribute value to identify the active tab + content
    $(activeTab).removeClass('hide') #Fade in the active content
    false

  $(".search-btn").click ->
    terms = $("input#terms").val()
    object = $(this).data("object")
    href = "/search_results?object=#{object}&terms=#{terms}"

    $(@).closest(".tab_content").find("input, select").each ->
      href = href + "&#{$(this).attr('name')}=#{$(this).val()}"

    location.href = href

  $("#terms").keyup (event) ->
    $(".search-btn:visible, .search-btn:first").click() if event.keyCode == 13


  # activate tab button on load if non is activated
#  activeListItem = $("ul.tabsx li.activex")
#  $('ul.tabsx li:first a').click() if activeListItem.size() == 0
