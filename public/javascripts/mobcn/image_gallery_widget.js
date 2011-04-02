SMBS.MobileCampaign.ImageGalleryWidget = {
  
  campaign_id: '',
  _uploader:   '',
  
  init : function(mobile_campaign_id) {
    this.campaign_id = mobile_campaign_id
    
    // images as draggable
    this.draggable()
    
    // load images
    this.display_images(this.campaign_id)
    
    // init upload button
    this._uploader = new qq.FileUploader({
        element: document.getElementById('file-uploader'),
        action: SMBS.MobileCampaign.ImageGalleryWidget.mobile_campaign_images_path(),
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
        sizeLimit: 2097152 /*1Mb x 2*/,
        onComplete: function(id, file_name, response) {
          // append image
          SMBS.MobileCampaign.ImageGalleryWidget.append(JST['gallery_thumbnail'](response.model))
          // re-index draggable elements
          SMBS.MobileCampaign.ImageGalleryWidget.draggable()
          
          if(response.success) {
            SMBS.Application.show_notice('Файл '+file_name+' был загружен и сохранен на сервере')
            upload_status = _.detect($('.qq-upload-file'), function(item) { return $(item).text() == qq.FileUploaderBasic.prototype._formatFileName(file_name) })
            $(upload_status).parent().remove()
          } else {
            SMBS.Application.show_error(response.error || 'Файл не может быть сохранен из-за ошибки сети. Попробуйте немного позже')
          }
        }
    })
    
  }, // end init
  
  display_images: function(campaign_id, try_move_to) {
    if(campaign_id) {
      $.ajax( {
        type:     'get',
        dataType: 'json',
        url:      '/mobile/campaigns/'+campaign_id+'/images',
        beforeSend: function(request) {
          $('.navigation-tools .title').hide()
          $('.navigation-tools .loading').show()
        },
        success:  function(data) {
          if(data.models) { 
            if(try_move_to) SMBS.MobileCampaign.ImageGalleryWidget.Navi.cursor = try_move_to
          
            html = _.map(data.models, function(model) {return JST['gallery_thumbnail'](model)}).join('')
            SMBS.MobileCampaign.ImageGalleryWidget.Navi._show(html)
          }
        },
        complete: function(request) {
          $('.navigation-tools .loading').hide()
          $('.navigation-tools .title').show()
        }
      }) // end ajax
    } // end if
  },
  
  disable: function() {
    $('.gallery-widget .disabled').show()
    $('.qq-upload-button').hide()
  },
  
  enable: function() {
    $('.gallery-widget .disabled').hide()
    if(!$('.gallery-widget .items').children().length) $('.gallery-widget .enabled').show()
    $('.qq-upload-button').show()
    // substitute image upload path from undefined to real
    this._uploader._handler._options.action = this.mobile_campaign_images_path()
  },
  
  draggable: function() {
    // make all images a draggable
    $('.draggable').draggable('destroy')
    $('.draggable').draggable({appendTo: 'body', helper: 'clone'})
  },
  
  append: function(image_items) {
    $('.gallery-widget .notice').hide()
    $('.gallery-widget .items').append(image_items).trigger('change')
  },
  
  mobile_campaign_images_path: function() {
    return '/mobile/campaigns/'+this.campaign_id+'/images'
  }
} // end SMBS.MobileCampaign.ImageGalleryWidget


SMBS.MobileCampaign.ImageGalleryWidget.Navi = {
  
  cursor: undefined,
  map:    undefined,
  
  
  go_to: function(direction) {
    
    if(this.map == undefined) {
      $.ajax({
        async:    false,
        type:     'get',
        dataType: 'json',
        url:      '/mobile/campaigns/ids_with_images',
        success:   function(data) {
          if(data.ids) {
            SMBS.MobileCampaign.ImageGalleryWidget.Navi.map    = data.ids
            indexOf = SMBS.MobileCampaign.ImageGalleryWidget.Navi.map.indexOf(SMBS.MobileCampaign.ImageGalleryWidget.campaign_id)
            SMBS.MobileCampaign.ImageGalleryWidget.Navi.cursor = indexOf == -1 ? SMBS.MobileCampaign.ImageGalleryWidget.Navi.map.length - 1 : indexOf
          } // end if
        } // end success
      }) // end ajax
    }
    
    if(this.map) switch(direction) {
      case  "left": return this._show_after_load(this.cursor - 1)
      case "right": return this._show_after_load(this.cursor + 1)
    }
  },
  
  _show_after_load: function(try_move_to) {
    if(campaign_id = this.map[try_move_to]) {
      SMBS.MobileCampaign.ImageGalleryWidget.display_images(campaign_id, try_move_to)
    } // end if
    
    return false
  }, // end _load
  
  _show: function(html) {
    $('.gallery-widget .items').children().remove()
    SMBS.MobileCampaign.ImageGalleryWidget.append(html)
    SMBS.MobileCampaign.ImageGalleryWidget.draggable()
  }
}