var TextsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },

  /*public*/
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    text_container = element.find('.text_container');
    textarea       = text_container.find('textarea');
    
    if(data) { 
      textarea.val(data.value); 
    }
    
    //textarea resizer
    element_resizer = element.find('.element_resizer');
    
    element_resizer.mousedown(function(e) {
      start_y = e.pageY
      element.bind('mousemove', function(e) {
        absolute_y = e.pageY - start_y
        textarea_height = parseInt(textarea.css('height')) + absolute_y
        if(textarea_height >= 25 && textarea_height <= 800) {
          start_y += absolute_y
          textarea.css('height', textarea_height)
        }
      })
    })
    
    jQuery('body').mouseup(function(e) {
      element.unbind('mousemove')
    })
    
    element.show();
  },
  
  
  to_object : function(/*JQuery*/ element) {
    this.partial_model.value = jQuery(element).find('textarea').val();
    return this.partial_model;
  },

});