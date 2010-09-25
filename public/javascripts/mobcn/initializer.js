// initialize document builder
$(document).ready(function() {
  
  // image draggable property
  $('.draggable').draggable({appendTo: 'body', helper: 'clone'});
  
  $('#preview_or_edit').toggle(
    function() {
      $('#preview_or_edit').text('Back');
      $('#document, #document_partials, #gallery').hide();
      $('#save').click();
      refresh_preview_iframe();
      $('#preview, #themes').show();
    },

    function() {
      $('#preview_or_edit').text('Preview');
      $('#preview, #themes').hide();
      $('#document, #document_partials, #gallery').show();
    }
  );
  
  $('#save').click(function() {
    $.ajax({
      type:     page_id ? 'put' : 'post',
      dataType: 'json',
      url:      page_id ? '/mobile/campaigns/' + page_id : '/mobile/campaigns',
      data:     'mbc[title]='+$('#title').val()+'&mbc[document_model]='+builder.serialize_document(),
      success: function(data) {
        page_id = data.page_id;
        switch_save_to_update();
      }
    });
  });
  
  $('#resolutions input').click(function() {
    reg = /(\d+)x(\d+)/;
    resolution = $(this).next().text();
    width  = parseInt(resolution.match(reg)[1]);
    height = parseInt(resolution.match(reg)[2]);
    $('#preview iframe').css('width', width).css('height', height);
  });

}); // end ready()

switch_save_to_update = function() {
  if($('#save').text() != 'Обновить' && page_id > 0) {
    $('#save').text('Обновить');
  }
}

refresh_preview_iframe = function() {
  $('#preview').empty();
  $('<iframe id="preview_frame" src="/pages/' + page_id + '">').appendTo('#preview');
}