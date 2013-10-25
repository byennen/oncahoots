  jQuery(document).ready(function() {//Default Action
    $('.carou-fred-sel').carouFredSel({
          items: 3,
          auto: false,
          prev: '#prev2',
          next: '#next2',
          pagination: "#pager2",
          mousewheel: true,
          swipe: {
            onMouse: true,
            onTouch: true
          }, 
          height: 252
        });
    $('.community-slide').carouFredSel({
      items: 3,
      auto: false,
      prev: '.cprev',
      next: '.cnext',
      pagination: "#pager2",
      mousewheel: true,
      swipe: {
        onMouse: true,
        onTouch: true
      }, 
        height: 400
    });
    $('.community-slide1').carouFredSel({
      items: 3,
      auto: false,
      prev: '.cprev1',
      next: '.cnext1',
      pagination: "#pager2",
      mousewheel: true,
      swipe: {
        onMouse: true,
        onTouch: true
      }, 
        height: 400
    });
    $('.community-slide2').carouFredSel({
      items: 3,
      auto: false,
      prev: '.cprev2',
      next: '.cnext2',
      pagination: "#pager2",
      mousewheel: true,
      swipe: {
        onMouse: true,
        onTouch: true
      }, 
        height: 400
    });
  $("#events").flexisel({visibleItems: 3});
  $("#free-food").flexisel({visibleItems: 3});

  $(".tab_content").hide(); //Hide all content
  $("ul.tabs3 li:first").addClass("active").show(); //Activate first tab
  $(".tab_content:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs3 li").click(function() {
    $("ul.tabs3 li").removeClass("active"); //Remove any "active" class
    $("ul.tabs3 a").removeClass("selected");
    $(this).addClass("active"); //Add "active" class to selected tab
    jQuery(this).children("a").addClass('selected');
    //console.log($(this).toSource());
    $(".tab_content").hide(); //Hide all tab content
    var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active content
    return false;
  });
  $(".tab_content2").hide(); //Hide all content
  $("ul.tabs4 li:first").addClass("active").show(); //Activate first tab
  $(".tab_content2:first").show(); //Show first tab content

  //On Click Event
  $("ul.tabs4 li").click(function() {
    $("ul.tabs4 li").removeClass("active"); //Remove any "active" class
    $("ul.tabs4 a").removeClass("selected");
    $(this).addClass("active"); //Add "active" class to selected tab
    jQuery(this).children("a").addClass('selected');
    //console.log($(this).toSource());
    $(".tab_content2").hide(); //Hide all tab content
    var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
    $(activeTab).fadeIn(); //Fade in the active content
    return false;
  });


});
