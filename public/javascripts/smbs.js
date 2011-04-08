var SMBS = {};

SMBS.MobileCampaign = {};


SMBS.Application = {
  
  show_notice : function(message) {
    flash = jQuery('.flash.notice');
    flash.show().text(message).fadeOut(6000);
  },
  
  show_error : function(message) {
    flash = jQuery('.flash.error');
    flash.show().text(message).fadeOut(12000);
  }
  
};


SMBS.Popup = {
  
  contentStorage: {},
  
  init: function(){
    jQuery('body').append('<div id="shadow" style="display: none">&nbsp;</div>'+
                          '<div id="popup" style="display: none">'+
                          '<div class="pop-tr">&nbsp;</div>'+
                          '<div class="pop-tl">&nbsp;</div>'+
                          '<div class="pop-br">&nbsp;</div>'+
                          '<div class="pop-bl">&nbsp;</div>'+
                          '<div class="pop-vert">&nbsp;</div>'+
                          '<div class="pop-hor">&nbsp;</div>'+
                            '<div id="popupClose">&nbsp;</div>'+
                            '<div id="loading" style="display: none">'+
                                '<img alt="" src="/images/gray_loader.gif"><br />'+
                                'Загрузка...'+
                            '</div>'+
                            '<div class="popup-content">'+
                            '</div>'+
                          '</div>');

    jQuery('.popupContent').each(function(){
      SMBS.Popup.extract(this, this.id);
    });
                          
    jQuery('#popupClose').click(function(){
      SMBS.Popup.close();
    });
  },


  extract : function(selector, name) {
    this.contentStorage[name] = jQuery(selector).html();
    jQuery(selector).remove();
  },

  open: function(content, width, height, options){
    if(!options) options = {};
    
    if(options.closeable == false) { jQuery('#popupClose').hide(); }
    
    // try to extract content from the storage
    // name is generally less than 200 chars, while content is more
    var storedContent = content;
    if (content.length < 200) { storedContent = this.contentStorage[content]; }
    if (storedContent !== undefined ) { content = storedContent; }
    
    jQuery("#popup .popup-content").html(content);
    SMBS.Popup.setPosition(width, height);
    jQuery("#shadow").show();
    jQuery('.textarea textarea').keyup(function() {
      SMBS.Popup.countMsgLength(options.textarea_max_length);
    });
    SMBS.Popup.countMsgLength(options.textarea_max_length);
    jQuery(document).trigger('on_popup_open');
  },
  
  close: function(){
    jQuery("#shadow, #popup").hide();
    jQuery(document).trigger('on_popup_close');
  },
  
  setPosition: function(width, height){
    var popup = jQuery("#popup");
    var currentWindow = jQuery(window);
    if (jQuery('#popup .popup-footer').length > 0) {
      if (height == 'auto') {
        jQuery("#popup .popup-content").css('padding-bottom', '80px');
      } else {
        jQuery("#popup .popup-content").css('padding-bottom', '0px');
      }
    }
    if(jQuery('#popup .valign-middle').length != 0) {
      var topSpace = (jQuery("#popup .popup-content").height() - jQuery("#popup .valign-middle").height())/2;
      jQuery("#popup .valign-middle").css('margin-top', topSpace);
    }
    popup.width(width || 'auto').height(height || 'auto').css({'left': (currentWindow.width() - popup.width())/2, 'top': jQuery(document).scrollTop() + (currentWindow.height() - popup.height())/2}).show();
  },
  
  openLoading: function(){
    jQuery('#loading img').css('margin-top', jQuery('#popup').height()/2 - 50).show();
    jQuery('#loading').show();
  },
  
  closeLoading: function(){
    jQuery('#loading').hide();
  },
  
  countMsgLength: function(max_message_length){
    if(!max_message_length) max_message_length = 140;
    var textarea = jQuery('#popup .textarea textarea');
    if (textarea.length == 0) return;
    var counter = jQuery('#popup .textarea p');

    chars_left = max_message_length - textarea.val().length;

    counter.text(chars_left);
    if (textarea.val().length > max_message_length) { 
      counter.addClass('red');
    } else {
      counter.removeClass('red');
    }
  }
  
}; jQuery(document).ready(function() { SMBS.Popup.init(); });


SMBS.Bubble = {

  init: function(){

    // jQuery('body').click(function(){
    //   SMBS.Bubble.close();
    // });
    jQuery('body').append('<span class="bubble" style="display: none;">'+
                          '<span class="text"></span>'+
                          '<span class="close" onclick="SMBS.Bubble.close();">&nbsp;</span>'+
                          '<span class="arrow">&nbsp;</span>'+
                          '</span>');
  },

  open: function(obj, content, type){

    jQuery('.bubble').removeClass('error');
    jQuery('.bubble .text').text(content);
    if(type == 'error') {
      jQuery('.bubble').addClass('error');
      jQuery('.bubble').css({'top':($(obj).offset().top - jQuery('.bubble').height() - 20), 'left':($(obj).offset().left - 20)}).show();
      jQuery(obj).bind('focus', function(){
        SMBS.Bubble.close();
        $(this).removeClass("error-field");
      });
    } else {
      jQuery('.bubble').css({'top':($(obj).offset().top - jQuery('.bubble').height() - 20), 'left':($(obj).offset().left - 150)}).show();
    }
  },

  close: function(){
    jQuery(".bubble").hide();
  }

};