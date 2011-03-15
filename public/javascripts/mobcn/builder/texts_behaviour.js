var TextsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },

  /*public*/
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    text_container = element.find('.text_container');
    textarea       = text_container.find('textarea');
    
    //populate partial
    if(data) {
      if(data.value)         textarea.val(data.value);
      if(data.window_height) textarea.css('height', data.window_height);
    }
    
    //textarea resizer
    element_resizer = element.find('.element_resizer');
    
    element_resizer.mousedown(function(e) {
      start_y  = e.pageY;
      element  = jQuery(this).parents('.document_partial');
      textarea = element.find('textarea');
      element.bind('mousemove', function(e) {
        absolute_y = e.pageY - start_y;
        textarea_height = parseInt(textarea.css('height')) + absolute_y;
        if(textarea_height >= 25 && textarea_height <= 800) {
          start_y += absolute_y;
          textarea.css('height', textarea_height);
        }
      })
    });
    
    jQuery('body').mouseup(function(e) {
      element.unbind('mousemove');
    });
    //end textarea resizer
    
    element.show();
  },
  
  
  to_object : function(/*JQuery*/ element) {
    this.partial_model.value         = element.find('textarea').val();
    this.partial_model.window_height = parseInt(element.find('textarea').css('height'));
    
    return this.partial_model;
  }
});