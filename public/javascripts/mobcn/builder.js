var Builder = Class.extend({

  document :          '#document',
  document_partial :  '.document_partial',
  document_partials : {},

  init : function(document_partials) {
    this.document_partials = document_partials;
    //this.style_model       = new StyleModel();

    /* 'this' context as proxied object */
    var place_container_to_document_proxy = $.proxy(this._place_container_to_document, this);

    /* init document partials listeners */
    $('#document_partials ul').find('li').each(function(/*<li>*/index) {
      $(this).click(function() {
        place_container_to_document_proxy($(this).attr('id'));
      });
    });

    /* common behaviour */
    $('#document').sortable({
      axis:   'y',
      handle: '.toolbar .move'
    });
    
    $('.toolbar .remove').live('click', function() {
      if(confirm('Are you sure?')) {
        $(this).parentsUntil('#document').remove();
      }
    });
  },
  
  
  /*public*/
  serialize_document : function() {
    document_model = [];
    this._all_document_partials().each(function(index, element) {
      document_model[index] = $(element).data('behaviour').to_object(element);
    });
    return JSON.stringify(document_model);
  },
  
  inject_serialized_document : function(model) {
    for(partial in model) {
      this._place_container_to_document(model[partial].type, model[partial]);
    }
  },

  /*private*/
    _place_container_to_document : function(id, data) {
      container_id = PartialRegistry.to_s(id);
      behaviour = PartialRegistry.init_behaviour(id);
      if(container_id && behaviour) {
        $(this.document).append(this.document_partials[container_id]);
        element = this._all_document_partials().last();
        element.data('behaviour', behaviour);
        behaviour.apply(element, data);
      }
    },
    
    _all_document_partials : function() {
      return $(this.document).find(this.document_partial);
    }
});