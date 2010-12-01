SMBS.MobileCampaign.ImageGalleryWidget = {
  
  init : function(mobile_campaign_id) {
    $(document).ready(function() {
      // init upload button
      var uploader = new qq.FileUploader({
          element: document.getElementById('file-uploader'),
          action: SMBS.MobileCampaign.ImageGalleryWidget.mobile_campaign_images_path(mobile_campaign_id),
          allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
          sizeLimit: 1048576 /*512kbx2*/,
          onComplete: function(id, file_name, response) {
            $('.assets').append(response.html).trigger('change')
            // re-index draggable elements
            $('.draggable').draggable('destroy')
            $('.draggable').draggable({appendTo: 'body', helper: 'clone'})
            // reset download progress bar
            $('.qq-upload-list').empty()
            
            if(response.success) {
              show_notice('Файл '+file_name+' был загружен и сохранен на сервере')
            } else {
              show_notice(response.error || 'Файл не может быть сохранен из-за ошибки сети. Попробуйте немного позже')
            }
          }
      });
      
      
    }); // end ready event handler
  }, // end init
  
  mobile_campaign_images_path: function(id) {
    return '/mobile/campaigns/'+id+'/images'
  }
  
}