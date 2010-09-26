// initialize document builder
$(document).ready(function() {
  
  // image draggable property
  $('.draggable').draggable({appendTo: 'body', helper: 'clone'});
  
  $('#preview').click(function() {
    if(page_id) window.location='/mobile/campaigns/'+page_id+'/preview';
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
      }
    });
  });
  
}); // end ready()

switch_save_to_update = function() {
  if($('#save').text() != 'Обновить' && page_id > 0) {
    $('#save').text('Обновить');
  }
}