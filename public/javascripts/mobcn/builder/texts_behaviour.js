var TextsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },

  /*public*/
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    text_container = element.find('.text_container');

    if(data) { text_container.find('textarea').val(data.value); }
    element.show();
  },
  
  
  to_object : function(/*JQuery*/ element) {
    this.partial_model.value = $(element).find('textarea').val();
    return this.partial_model;
  },

});