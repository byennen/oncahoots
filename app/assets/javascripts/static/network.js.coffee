$(document).ready ->
  $("#add").click ->
    $(".circlee").show()

  $("#add2").click ->
    $(".circlee2").show()

  $("#add3").click ->
    $(".circlee3").show()

  $(".selectyze2").Selectyze theme: "mac"
  $("#edt").click ->
    if $(".same").css("display") is "block"
      $(".same").css "display", "none"
    else
      $(".same").css "display", "block"

  $("#edt").on "click", ->
    $(".low").hide()
    $(".doe").show()

  $(".tab_content").hide() #Hide all content
  $("ul.tabs li:first a").addClass("active2").show() #Activate first tab
  $(".tab_content:first").show() #Show first tab content

  #On Click Event
  $("ul.tabs li").click ->
    $("ul.tabs li a").removeClass "active2" #Remove any "active" class
    $(this).addClass "active2" #Add "active" class to selected tab
    $(".tab_content").hide() #Hide all tab content
    activeTab = $(this).find("a").attr("href") #Find the rel attribute value to identify the active tab + content
    $(activeTab).fadeIn() #Fade in the active content
    false

  $(".tab_content2").hide() #Hide all content
  $("ul.tabs2 li:first a").addClass("active22").show() #Activate first tab
  $(".tab_content2:first").show() #Show first tab content

  #On Click Event
  $("ul.tabs2 li").click ->
    $("ul.tabs2 li").removeClass "active22" #Remove any "active" class
    $(this).addClass "active22" #Add "active" class to selected tab
    $(".tab_content2").hide() #Hide all tab content
    activeTab = $(this).find("a").attr("href") #Find the rel attribute value to identify the active tab + content
    $(activeTab).fadeIn() #Fade in the active content
    false

  $("#edt").click ->
    $(".edtitor").val($(".text1").hide().text()).show()
    $(".edtitor2").val($(".text22").hide().text()).show()
    $(".edtitor3").val($(".text3").hide().text()).show()
    $(".edtitor4").val($(".text4").hide().text()).show()
    $(".edtitor5").val($(".text5").hide().text()).show()
    $(".edtitor6").val($(".text6").hide().text()).show()
    $(".edtitor7").val($(".text7").hide().text()).show()
    $(".edtitor8").val($(".text8").hide().text()).show()
    $(".edtitor9").val($(".text9").hide().text()).show()
    $(".edtitor1a").val($(".text1a").hide().text()).show()
    $(".edtitor2a").val($(".text2a").hide().text()).show()
    $(".edtitor3a").val($(".text3a").hide().text()).show()
    $(".edtitor4a").val($(".text4a").hide().text()).show()
    $(".edtitor5a").val($(".text5a").hide().text()).show()
    $(".edtitor6a").val($(".text6a").hide().text()).show()
    $(".edtitor7a").val($(".text7a").hide().text()).show()
    $(".edtitor8a").val($(".text8a").hide().text()).show()
    $(".edtitor9a").val($(".text9a").hide().text()).show()
    $(".edtitor1b").val($(".text1b").hide().text()).show()
    $(".edtitor2b").val($(".text2b").hide().text()).show()
    $(".edtitor3b").val($(".text3b").hide().text()).show()
    $(".edtitor4b").val($(".text4b").hide().text()).show()
    $(".edtitor4b").val($(".text4b").hide().text()).show()
    $(".edtitor5b").val($(".text5b").hide().text()).show()
    $(".edtitor6b").val($(".text6b").hide().text()).show()
    $(".edtitor7b").val($(".text7b").hide().text()).show()
    $(".edtitor8b").val($(".text8b").hide().text()).show()
    $(".edtitor9b").val($(".text9b").hide().text()).show()

