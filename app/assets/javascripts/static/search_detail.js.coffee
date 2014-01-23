$(document).ready ->
  $("#selector").gentleSelect() # apply gentleSelect with default options
  $(".selectyze2").Selectyze theme: "mac"
  $("#datepicker").datepicker inline: true
  $("#datepicker2").datepicker inline: true
  $(".selectyze2").Selectyze theme: "mac"
  $(".basic").fancySelect()

  #Default Action
  $(".tab_content").hide() #Hide all content
  $("ul.tabsx li:first").addClass("activex").show() #Activate first tab
  $(".tab_content:first").show() #Show first tab content

  #On Click Event
  $("ul.tabsx li").click ->
    $("ul.tabsx li").removeClass "activex" #Remove any "active" class
    $(this).addClass "activex" #Add "active" class to selected tab
    $(".tab_content").hide() #Hide all tab content
    activeTab = $(this).find("a").attr("href") #Find the rel attribute value to identify the active tab + content
    $(activeTab).fadeIn() #Fade in the active content
    false
