var LikeitsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },
  
  /* public */
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    $(element).show();
  },
  
  to_object : function(/*JQuery*/ element) {
    return this.partial_model;
  },
  
});