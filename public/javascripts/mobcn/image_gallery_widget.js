SMBS.MobileCampaign.ImageGalleryWidget = {
  
  campaign_id: '',
  _uploader:    '',
  
  init : function(mobile_campaign_id) {
    this.campaign_id = mobile_campaign_id
    
    // init upload button
    this._uploader = new qq.FileUploader({
        element: document.getElementById('file-uploader'),
        action: SMBS.MobileCampaign.ImageGalleryWidget.mobile_campaign_images_path(),
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
        sizeLimit: 1048576 /*512kbx2*/,
        onComplete: function(id, file_name, response) {
          // add image to gallery
          $('.gallery-widget .enabled').hide()
          $('.gallery-widget .items').append(response.html).trigger('change')
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
    })
    
  }, // end init
  
  disable: function() {
    $('.gallery-widget .disabled').show()
    $('.qq-upload-button').hide()
  },
  
  enable: function(show_enabled_notice) {
    $('.gallery-widget .disabled').hide()
    if(show_enabled_notice) $('.gallery-widget .enabled').show()
    $('.qq-upload-button').show()
    // substitute image upload path from undefined to real
    this._uploader._handler._options.action = this.mobile_campaign_images_path()
  },
  
  mobile_campaign_images_path: function() {
    return '/mobile/campaigns/'+this.campaign_id+'/images'
  },
  
} // end SMBS.MobileCampaign.ImageGalleryWidget