// initialize document builder
$(document).ready(function() {

  $('#settings').click(function() {
    if(page_id) {
      $('#save').click()
      window.location='/mobile/campaigns/' + page_id + '/settings'
    }
    return false
  }),

  $('#save').click(function() {
    csrf = 'authenticity_token=' + jQuery('meta[name="csrf-token"]').attr('content') + '&utf=✓'
    $.ajax({
      async:    false,
      type:     page_id ? 'put' : 'post',
      dataType: 'json',
      url:      page_id ? '/mobile/campaigns/' + page_id : '/mobile/campaigns',
      data:     csrf + '&mbc[title]=' + $('#title').val() + '&mbc[document_model]=' + builder.serialize_document(),
      success: function(data) {
        page_id = data.mbc_id;
        if(data.success) {
          switch_save_to_update()
          SMBS.Application.show_notice('Страница была успешно сохранена')
          
          // image gallery widget ready for image upload!
          SMBS.MobileCampaign.ImageGalleryWidget.campaign_id = page_id
          SMBS.MobileCampaign.ImageGalleryWidget.enable()
        } else {
          SMBS.Application.show_error(data.error)
        }
      },
      error: function() { SMBS.Application.show_error('Сохранение не может быть выполнено из-за ошибки сети. Попробуйте позже') }
    });
    return false;
  });

  // initialize behaviours
  ImagesBehaviour.Initializer.init()

}); // end ready()

switch_save_to_update = function() {
  if($('#save').text() != 'Обновить' && page_id > 0) {
    $('#save').text('Обновить')
  }
}