// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker
//= require jquery.tagsinput
//= require jquery_nested_form
//= require jquery.remotipart
//= require_tree .
//
$(function() {

  $('#user_alumni').click(function () {
    alert("alumni clicked");
    $("#professional_fields").toggle(this.checked);
  });

  $(".toggle").click(function(){
    hidding = $($(this).data("target")).hasClass("hide");
    $($(this).data("toggle")).addClass("hide");
    if(hidding){
      $($(this).data("target")).removeClass("hide");
    }
  });

  $(".toggle1").click(function(){
    $($(this).data("toggle")).addClass("transparent");
    $($(this).data("target")).removeClass("transparent");
    $(".toggle1").removeClass('active');
    $(this).addClass('active');
  });

});

$(document).on('ready page:load', function(){ 
  $('.datepicker').datepicker({ format: 'mm/dd/yyyy' });
  $(".date-inputmask").inputmask("mm/dd/yyyy"); 
});