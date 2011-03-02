var LikeitsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },
  
  /* public */
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    
    element.find('.likeit_control input[name="title"]').keyup(function() {
      element.find('.likeit_container .likeit .button').text(jQuery(this).val())
    });
    element.find('.likeit_control input[type="radio"]').click(function() {
      element.find('.likeit_container div').removeClass().addClass('likeit').addClass(jQuery(this).val())
    });
    
    
    $(element).show();
  },
  
  to_object : function(/*JQuery*/ element) {
    return this.partial_model;
  },
  
});