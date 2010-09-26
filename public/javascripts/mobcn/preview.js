SMBS.MobileCampaign.Preview = {
  
  mobile_campaign_path : '',
  
  init : function(mobile_campaign_path) {
    
    SMBS.MobileCampaign.Preview.mobile_campaign_path = mobile_campaign_path;
    
    $(document).ready(function() {
      SMBS.MobileCampaign.Preview.toggle_preview();
      $('#resolutions li').click(function() {
        reg = /(\d+)x(\d+)/;
        resolution = $(this).text();
        width  = parseInt(resolution.match(reg)[1]);
        height = parseInt(resolution.match(reg)[2]);
        $('#preview iframe').css('width', width).css('height', height);
      });
    });
  },
  
  toggle_preview : function() {
    $('#preview').empty();
    $('<iframe id="preview_frame" src="'+SMBS.MobileCampaign.Preview.mobile_campaign_path+'">').appendTo('#preview');
  }
  
};