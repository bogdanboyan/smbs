SMBS.MobileCampaign.AssetUploader = {
  
  init : function(upload_image_mobile_assets_path) {
    $(document).ready(function() {
      var uploader = new qq.FileUploader({
          element: document.getElementById('file-uploader'),
          action: upload_image_mobile_assets_path,
          allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
          sizeLimit: 1048576 /*512kb x2*/,
          onComplete: function(id, file_name, data) {
            $('.assets').prepend(data.html).trigger('change');
            // re-index draggable elements
            $('.draggable').draggable('destroy');
            $('.draggable').draggable({appendTo: 'body', helper: 'clone'});
            // clear download progress bar
            $('.qq-upload-list').empty();
            show_notice('Файл '+file_name+' был загружен и сохранен на сервере');
          }
      });
      
    });
  }
  
}