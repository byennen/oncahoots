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

  $("#edt").click ->
    $(".form-field").hide()
    $(".form-field[type=submit]").show()
    $(".field-edit").show()
    $(".edtitor").show()
    $(".edtitor2").show()
    $(".edtitor3").show()
    $(".edtitor4").show()
    $(".edtitor5").show()
    $(".edtitor6").show()
    $(".edtitor7").show()
    $(".edtitor8").show()
    $(".edtitor9").show()
    $(".edtitor1a").show()
    $(".edtitor2a").show()
    $(".edtitor3a").show()
    $(".edtitor4a").show()
    $(".edtitor5a").show()
    $(".edtitor6a").show()
    $(".edtitor7a").show()
    $(".edtitor8a").show()
    $(".edtitor9a").show()
    $(".edtitor1b").show()
    $(".edtitor2b").show()
    $(".edtitor3b").show()
    $(".edtitor4b").show()
    $(".edtitor4b").show()
    $(".edtitor5b").show()
    $(".edtitor6b").show()
    $(".edtitor7b").show()
    $(".edtitor8b").show()
    $(".edtitor9b").show()

  $(document).on 'nested:fieldAdded:faqs', ->
    field = event.field;
    field.find('.field-edit').fadeIn()


  $('.profile_main_content ul.nav.nav-pills li a').on 'click', (event) ->
    tab_id = $(event.target).attr('href').match(/^#(.*)$/)[1]
    if $('a#edt.edit').size() > 0
      href = $('a#edt.edit').attr('href').match(/^([^\?]*)\??.*$/)[1]
      href = href + "?tab_id=" + tab_id
      $('a#edt.edit').attr('href', href)

  tabName = $('#network.profile_main_content').attr("data-tab-id")
  tabName = "resume" if !tabName || tabName == ""
  $('a[href="#'+tabName+'"]').click()

