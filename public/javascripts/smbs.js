var SMBS = {};

SMBS.MobileCampaign = {};


SMBS.Application = {
  
  show_notice : function(message) {
    flash = $('.flash.notice');
    flash.show().text(message).fadeOut(6000);
  },
  
  show_error : function(message) {
    flash = $('.flash.error');
    flash.show().text(message).fadeOut(12000);
  },
  
};