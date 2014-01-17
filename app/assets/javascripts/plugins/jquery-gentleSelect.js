/*
 * jQuery gentleSelect plugin
 * http://shawnchin.github.com/jquery-gentleSelect
 *
 * Copyright (c) 2010 Shawn Chin. 
 * Licensed under the MIT license.
 * 
 * Usage:
 *  (JS)
 *
 *  $('#myselect').gentleSelect(); // default. single column
 * 
 * $('#myselect').gentleSelect({ // 3 columns, 150px wide each
 *    itemWidth : 150,
 *    columns   : 3,
 * });
 * 
 *  (HTML)
 *  <select id='myselect'><options> .... </options></select>
 *
 */
(function($) {
    
    var defaults = {
        itemWidth : undefined,
        columns   : undefined,
        rows      : undefined,
        title     : undefined,
        prompt    : "Make A Selection",
        maxDisplay: 0,  // set to 0 for unlimited
        openSpeed       : 400,
        closeSpeed      : 400,
        openEffect      : "slide",
        closeEffect     : "slide",
        hideOnMouseOut  : true
    }

    function defined(obj) {
        if (typeof obj == "undefined") { return false; }
        else { return true; }
    }

    function hasError(c, o) {
        if (defined(o.columns) && defined(o.rows)) {
            $.error("gentleSelect: You cannot supply both 'rows' and 'columns'");
            return true;
        }
        if (defined(o.columns) && !defined(o.itemWidth)) {
            $.error("gentleSelect: itemWidth must be supplied if 'columns' is specified");
            return true;
        }
        if (defined(o.rows) && !defined(o.itemWidth)) {
            $.error("gentleSelect: itemWidth must be supplied if 'rows' is specified");
            return true;
        }
        if (!defined(o.openSpeed) || typeof o.openSpeed != "number" && 
                (typeof o.openSpeed == "string" && (o.openSpeed != "slow" && o.openSpeed != "fast"))) { 
            $.error("gentleSelect: openSpeed must be an integer or \"slow\" or \"fast\"");
            return true;
        }
        if (!defined(o.closeSpeed) || typeof o.closeSpeed != "number" && 
                (typeof o.closeSpeed == "string" && (o.closeSpeed != "slow" && o.closeSpeed != "fast"))) { 
            $.error("gentleSelect: closeSpeed must be an integer or \"slow\" or \"fast\"");
            return true;
        }
        if (!defined(o.openEffect) || (o.openEffect != "fade" && o.openEffect != "slide")) {
            $.error("gentleSelect: openEffect must be either 'fade' or 'slide'!");
            return true;
        }
        if (!defined(o.closeEffect)|| (o.closeEffect != "fade" && o.closeEffect != "slide")) {
            $.error("gentleSelect: closeEffect must be either 'fade' or 'slide'!");
            return true;
        }
        if (!defined(o.hideOnMouseOut) || (typeof o.hideOnMouseOut != "boolean")) {
            $.error("gentleSelect: hideOnMouseOut must be supplied and either \"true\" or \"false\"!");
            return true;
        }
        return false;
    }

    function optionOverrides(c, o) {
        if (c.attr("multiple")) {
            o.hideOnMouseOut = true; // must be true or dialog will never hide
        }
    }

    function getSelectedAsText(elemList, opts) { 
        // If no items selected, return prompt
        if (elemList.length < 1) { return opts.prompt; }

        // Truncate if exceed maxDisplay
        if (opts.maxDisplay != 0 && elemList.length > opts.maxDisplay) {
            var arr = elemList.slice(0, opts.maxDisplay).map(function(){return $(this).text();});
            arr.push("...");
        } else {
            var arr = elemList.map(function(){return $(this).text();});
        }
        return arr.get().join(", ");
    }

    var methods = {
        init : function(options) {
            var o = $.extend({}, defaults, options);

            if (hasError(this, o)) { return this; }; // check for errors
            optionOverrides(this, o); // 
            this.hide(); // hide original select box
            
            // initialise <span> to replace select box
            label_text = getSelectedAsText(this.find(":selected"), o);
            var label = $("<span class='gentleselect-label gentleselect-label2 gentleselect-label3'>" + label_text + "</span>")
                .insertBefore(this)
                .bind("mouseenter.gentleselect", event_handlers.labelHoverIn)
                .bind("mouseleave.gentleselect", event_handlers.labelHoverOut)
                .bind("click.gentleselect", event_handlers.labelClick)
                .data("root", this);
            this.data("label", label)
                .data("options", o);
            
            // generate list of options
            var ul = $("<ul></ul>");
            this.find("option").each(function() { 
                var li = $("<li>" + $(this).text() + "</li>")
                    .data("value", $(this).attr("value"))
                    .data("name", $(this).text())
                    .appendTo(ul);
                if ($(this).attr("selected")) { li.addClass("selected"); } 
            });

            // build dialog box
            var dialog = $("<div class='gentleselect-dialog gentleselect-dialog2 gentleselect-dialog3'></div>")
                .append(ul)
                .insertAfter(label)
                .bind("click.gentleselect", event_handlers.dialogClick)
                .bind("mouseleave.gentleselect", event_handlers.dialogHoverOut)
                .data("label", label)
                .data("root", this);
            this.data("dialog", dialog);
           
            // if to be displayed in columns
            if (defined(o.columns) || defined(o.rows)) {

                // Update CSS
                ul.css("float", "left")
                    .find("li").width(o.itemWidth).css("float","left");
                    
                var f = ul.find("li:first");
                var actualWidth = o.itemWidth 
                    + parseInt(f.css("padding-left")) 
                    + parseInt(f.css("padding-right"));
                var elemCount = ul.find("li").length;
                if (defined(o.columns)) {
                    var cols = parseInt(o.columns);
                    var rows = Math.ceil(elemCount / cols);
                } else {
                    var rows = parseInt(o.rows);
                    var cols = Math.ceil(elemCount / rows);
                }
                dialog.width(actualWidth * cols);

                // add padding
                for (var i = 0; i < (rows * cols) - elemCount; i++) {
                    $("<li style='float:left' class='gentleselect-dummy'><span>&nbsp;</span></li>").appendTo(ul);
                }

                // reorder elements
                var ptr = [];
                var idx = 0;
                ul.find("li").each(function() {
                    if (idx < rows) { 
                        ptr[idx] = $(this); 
                    } else {
                        var p = idx % rows;
                        $(this).insertAfter(ptr[p]);
                        ptr[p] = $(this);
                    }
                    idx++;
                });
            } else if (typeof o.minWidth == "number") {
                dialog.css("min-width", o.minWidth);
            }

            if (defined(o.title)) {
                $("<div class='gentleselect-title gentleselect-title2 gentleselect-title3'>" + o.title + "</div>").prependTo(dialog);
            }

            // ESC key should hide all dialog boxes
            $(document).bind("keyup.gentleselect", event_handlers.keyUp);

            return this;
        },

        // if select box was updated externally, we need to bring everything
        // else up to speed.
        update : function() {
            var opts = this.data("options");

            // Update li with selected data
            var v = (this.attr("multiple")) ? this.val() : [this.val()];
            $("li", this.data("dialog")).each(function() {
                var $li = $(this);
                var isSelected = ($.inArray($li.data("value"), v) != -1);
                $li.toggleClass("selected", isSelected);
            });

            // Update label
            var label = getSelectedAsText(this.find(":selected"), opts);
            this.data("label").text(label);
            
            return this;
        }
    };

    var event_handlers = {

        labelHoverIn : function() { 
            $(this).addClass('gentleselect-label-highlight'); 
        },

        labelHoverOut : function() { 
            $(this).removeClass('gentleselect-label-highlight'); 
        },

        labelClick : function() {
            var $this = $(this);
            var pos = $this.position();
            var root = $this.data("root");
            var opts = root.data("options");
            var dialog = root.data("dialog")
                .css("top", pos.top + $this.height())
                .css("left", pos.left + 1);
            if (opts.openEffect == "fade") {
                dialog.fadeIn(opts.openSpeed);
            } else {
                dialog.slideDown(opts.openSpeed);
            }
        },
    
        dialogHoverOut : function() {
            var $this = $(this);
            if ($this.data("root").data("options").hideOnMouseOut) {
                $this.hide();
            }
        },

        dialogClick : function(e) {
            var clicked = $(e.target);
            var $this = $(this);
            var root = $this.data("root");
            var opts = root.data("options");
            if (!root.attr("multiple")) {
                if (opts.closeEffect == "fade") {
                    $this.fadeOut(opts.closeSpeed);
                } else {
                    $this.slideUp(opts.closeSpeed);
                }
            }

            if (clicked.is("li") && !clicked.hasClass("gentleselect-dummy")) {
                var value = clicked.data("value");
                var name = clicked.data("name");
                var label = $this.data("label")

                if ($this.data("root").attr("multiple")) {
                    clicked.toggleClass("selected");
                    var s = $this.find("li.selected");
                    label.text(getSelectedAsText(s, opts));
                    var v = s.map(function(){ return $(this).data("value"); });
                    // update actual selectbox and trigger change event
                    root.val(v.get()).trigger("change");
                } else {
                    $this.find("li.selected").removeClass("selected");
                    clicked.addClass("selected");
                    label.text(clicked.data("name"));
                    // update actual selectbox and trigger change event
                    root.val(value).trigger("change");
                }
            }
        },

        keyUp : function(e) {
            if (e.keyCode == 27 ) { // ESC
                $(".gentleselect-dialog").hide();
            }
        }
    };

    $.fn.gentleSelect = function(method) {
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || ! method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.gentleSelect' );
        }   
    };


})(jQuery);







// Generated by CoffeeScript 1.4.0
(function() {
  var $;

  $ = window.jQuery || window.Zepto || window.$;

  $.fn.fancySelect = function(opts) {
    var isiOS, settings;
    if (opts == null) {
      opts = {};
    }
    settings = $.extend({
      forceiOS: false,
      includeBlank: false
    }, opts);
    isiOS = !!navigator.userAgent.match(/iP(hone|od|ad)/i);
    return this.each(function() {
      var copyOptionsToList, disabled, options, sel, trigger, updateTriggerText, wrapper;
      sel = $(this);
      if (sel.hasClass('fancified') || sel[0].tagName !== 'SELECT') {
        return;
      }
      sel.addClass('fancified');
      sel.css({
        width: 1,
        height: 1,
        display: 'block',
        position: 'absolute',
        top: 0,
        left: 0,
        opacity: 0
      });
      sel.wrap('<div class="fancy-select">');
      wrapper = sel.parent();
      if (sel.data('class')) {
        wrapper.addClass(sel.data('class'));
      }
      wrapper.append('<div class="trigger">');
      if (!(isiOS && !settings.forceiOS)) {
        wrapper.append('<ul class="options">');
      }
      trigger = wrapper.find('.trigger');
      options = wrapper.find('.options');
      disabled = sel.prop('disabled');
      if (disabled) {
        wrapper.addClass('disabled');
      }
      updateTriggerText = function() {
        return trigger.text(sel.find(':selected').text());
      };
      sel.on('blur', function() {
        if (trigger.hasClass('open')) {
          return setTimeout(function() {
            return trigger.trigger('close');
          }, 120);
        }
      });
      trigger.on('close', function() {
        trigger.removeClass('open');
        return options.removeClass('open');
      });
      trigger.on('click', function() {
        var offParent, parent;
        if (!disabled) {
          trigger.toggleClass('open');
          if (isiOS && !settings.forceiOS) {
            if (trigger.hasClass('open')) {
              return sel.focus();
            }
          } else {
            if (trigger.hasClass('open')) {
              parent = trigger.parent();
              offParent = parent.offsetParent();
              if ((parent.offset().top + parent.outerHeight() + options.outerHeight() + 20) > $(window).height() + $(window).scrollTop()) {
                options.addClass('overflowing');
              } else {
                options.removeClass('overflowing');
              }
            }
            options.toggleClass('open');
            if (!isiOS) {
              return sel.focus();
            }
          }
        }
      });
      sel.on('enable', function() {
        sel.prop('disabled', false);
        wrapper.removeClass('disabled');
        disabled = false;
        return copyOptionsToList();
      });
      sel.on('disable', function() {
        sel.prop('disabled', true);
        wrapper.addClass('disabled');
        return disabled = true;
      });
      sel.on('change', function(e) {
        if (e.originalEvent && e.originalEvent.isTrusted) {
          return e.stopPropagation();
        } else {
          return updateTriggerText();
        }
      });
      sel.on('keydown', function(e) {
        var hovered, newHovered, w;
        w = e.which;
        hovered = options.find('.hover');
        hovered.removeClass('hover');
        if (!options.hasClass('open')) {
          if (w === 13 || w === 32 || w === 38 || w === 40) {
            e.preventDefault();
            return trigger.trigger('click');
          }
        } else {
          if (w === 38) {
            e.preventDefault();
            if (hovered.length && hovered.index() > 0) {
              hovered.prev().addClass('hover');
            } else {
              options.find('li:last-child').addClass('hover');
            }
          } else if (w === 40) {
            e.preventDefault();
            if (hovered.length && hovered.index() < options.find('li').length - 1) {
              hovered.next().addClass('hover');
            } else {
              options.find('li:first-child').addClass('hover');
            }
          } else if (w === 27) {
            e.preventDefault();
            trigger.trigger('click');
          } else if (w === 13 || w === 32) {
            e.preventDefault();
            hovered.trigger('click');
          } else if (w === 9) {
            if (trigger.hasClass('open')) {
              trigger.trigger('close');
            }
          }
          newHovered = options.find('.hover');
          if (newHovered.length) {
            options.scrollTop(0);
            return options.scrollTop(newHovered.position().top - 12);
          }
        }
      });
      options.on('click', 'li', function(e) {
        sel.val($(this).data('value'));
        if (!isiOS) {
          sel.trigger('blur').trigger('focus');
        }
        options.find('.selected').removeClass('selected');
        $(e.currentTarget).addClass('selected');
        return sel.val($(this).data('value')).trigger('change').trigger('blur').trigger('focus');
      });
      options.on('mouseenter', 'li', function() {
        var hovered, nowHovered;
        nowHovered = $(this);
        hovered = options.find('.hover');
        hovered.removeClass('hover');
        return nowHovered.addClass('hover');
      });
      options.on('mouseleave', 'li', function() {
        return options.find('.hover').removeClass('hover');
      });
      copyOptionsToList = function() {
        var selOpts;
        updateTriggerText();
        if (isiOS && !settings.forceiOS) {
          return;
        }
        selOpts = sel.find('option');
        return sel.find('option').each(function(i, opt) {
          opt = $(opt);
          if (!opt.prop('disabled') && (opt.val() || settings.includeBlank)) {
            if (opt.prop('selected')) {
              return options.append("<li data-value=\"" + (opt.val()) + "\" class=\"selected\">" + (opt.text()) + "</li>");
            } else {
              return options.append("<li data-value=\"" + (opt.val()) + "\">" + (opt.text()) + "</li>");
            }
          }
        });
      };
      sel.on('update', function() {
        wrapper.find('.options').empty();
        return copyOptionsToList();
      });
      return copyOptionsToList();
    });
  };

}).call(this);






$(document).ready(function() {
				enableSelectBoxes();
			});
			
			function enableSelectBoxes(){
				$('div.selectBox').each(function(){
					$(this).children('span.selected').html($(this).children('div.selectOptions').children('span.selectOption:first').html());
					$(this).attr('value',$(this).children('div.selectOptions').children('span.selectOption:first').attr('value'));
					
					$(this).children('span.selected,span.selectArrow').click(function(){
						if($(this).parent().children('div.selectOptions').css('display') == 'none'){
							$(this).parent().children('div.selectOptions').css('display','block');
						}
						else
						{
							$(this).parent().children('div.selectOptions').css('display','none');
						}
					});
					
					$(this).find('span.selectOption').click(function(){
						$(this).parent().css('display','none');
						$(this).closest('div.selectBox').attr('value',$(this).attr('value'));
						$(this).parent().siblings('span.selected').html($(this).html());
					});
				});				
			}//-->