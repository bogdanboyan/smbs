var HeadersBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },
  
  /* public */
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    if(data) { element.find('input[name*="header"]').val(data.value); }
    $(element).show();
  },
  
  to_object : function(/*JQuery*/ element) {
    this.partial_model.value = element.find('input[name*="header"]').val();
    
    return this.partial_model;
  },
  
});