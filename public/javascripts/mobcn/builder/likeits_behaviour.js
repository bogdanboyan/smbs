var LikeitsBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },
  
  /* public */
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    
    likeit_control_input_title = element.find('.likeit_control input[name="title"]');
    likeit_control_input_tag   = element.find('.likeit_control input[name="tag"]');
    likeit_control_input_radio = element.find('.likeit_control input[type="radio"]');
    
    likeit_container_div           = element.find('.likeit_container div');
    likeit_container_likeit_button = element.find('.likeit_container .likeit .button');
    
    // unify radio group
    likeit_control_input_radio.each(function(index, radio) {
      unique_group_name = jQuery(radio).attr('name') + "-" + element.attr('id');
      jQuery(radio).attr('name', unique_group_name);
    });
    
    // apply data
    if(data) {
      if(data.title) {
        likeit_control_input_title.val(data.title);
        likeit_container_likeit_button.text(data.title);
      }
      
      if(data.tag) likeit_control_input_tag.val(data.tag);
      
      if(data.position) {
        element.find('.likeit_control input[type="radio"][value="'+data.position+'"]').attr('checked', true);
        likeit_container_div.removeClass().addClass('likeit').addClass(data.position);
      }
      
    } else { // init default state
      likeit_container_likeit_button.text(likeit_control_input_title.val());
      likeit_control_input_tag.val(likeit_control_input_tag.val() + element.attr('id'));
      element.find('.likeit_control input[type="radio"][value="posL"]').attr('checked', true);
    }
    
    // turn on interaction! WARN: Local variables point to last added likeits partial
    likeit_control_input_title.keyup(function() {
      element.find('.likeit_container .likeit .button').text(jQuery(this).val());
    });
    likeit_control_input_radio.click(function() {
      element.find('.likeit_container div').removeClass().addClass('likeit').addClass(jQuery(this).val());
    });
    
    $(element).show();
  },
  
  to_object : function(/*JQuery*/ element) {
    this.partial_model.title    = element.find('.likeit_control input[name="title"]').val();
    this.partial_model.tag      = element.find('.likeit_control input[name="tag"]').val();
    this.partial_model.position = element.find('.likeit_control input[type="radio"]:checked').val() || "posL";
    
    return this.partial_model;
  },
  
});