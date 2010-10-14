// initialize document builder
$(document).ready(function() {

  $('#preview').click(function() {
    if(page_id) {
      $('#save').click();
      window.location='/mobile/campaigns/'+page_id+'/preview';
    }
    return false;
  }),

  $('#save').click(function() {
    $.ajax({
      type:     page_id ? 'put' : 'post',
      dataType: 'json',
      url:      page_id ? '/mobile/campaigns/' + page_id : '/mobile/campaigns',
      data:     'mbc[title]='+$('#title').val()+'&mbc[document_model]='+builder.serialize_document(),
      success: function(data) {
        page_id = data.mbc_id;
        switch_save_to_update();
        show_notice('Страница была успешно ' + (page_id ? 'обновлена' : 'сохранена'));
      },
      error: function() { show_notice('Сохранение не может быть выполнено'); }
    });
    return false;
  });

  // initialize behaviours
  ImagesBehaviour.Initializer.init();
  
}); // end ready()

switch_save_to_update = function() {
  if($('#save').text() != 'Обновить' && page_id > 0) {
    $('#save').text('Обновить');
  }
}