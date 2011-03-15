var PartialRegistry = (function() {
  
  var map = {
    header       : 'header_container',
    images       : 'image_container',
    text         : 'text_container',
    delimiter    : 'delimiter_container',
    likeit       : 'likeit_container'
  }
  
  var behaviours = {
    header_container      : function(type) { return new HeadersBehaviour(type);      },
    image_container       : function(type) { return new ImagesBehaviour(type);       },
    text_container        : function(type) { return new TextsBehaviour(type);        },
    delimiter_container   : function(type) { return new DelimitersBehaviour(type);   },
    likeit_container      : function(type) { return new LikeitsBehaviour(type);      }
  }
  
  return {
    to_s           : function(id) { return map[id]; },
    init_behaviour : function(id) { return behaviours[this.to_s(id)](id); }
  }
})();

var PartialBehaviour = Class.extend({

  init : function(partial_type) {
    this.partial_type = partial_type;
    this.partial_model = {type:partial_type};
  },

  type : function() {
    return this.partial_type;
  },

  apply : function(/*JQuery*/ element) {
    this.element    = element;
    this.element_id = element.attr('id');
  }
});