var Builder = Class.extend({

  document          : '#document',
  document_partial  : '.document_partial',
  document_sequence : 0,
  document_partials : {},

  init : function(document_partials) {
    this.document_partials = document_partials;

    /* 'this' context as proxied object */
    var place_container_to_document_proxy = jQuery.proxy(this.append_document_partial, this);
    
    jQuery('#document_partials').delegate('a', 'click', function() {
      place_container_to_document_proxy(jQuery(this).attr('class'));
    });

    /* common behaviour */
    jQuery('#document').sortable({
      axis:   'y',
      handle: '.toolbar .move'
    });
    
    jQuery('.toolbar .remove').live('click', function() {
      if(confirm('Вы уверены что хотите удалить целый блок?')) {
        jQuery(this).parentsUntil('#document').remove();
      }
    });
  },
  
  
  /*public*/
  serialize_document : function() {
    document_model = [];
    this._all_document_partials().each(function(index, element) {
      document_model[index] = jQuery(element).data('behaviour').to_object(jQuery(element));
    });
    
    return JSON.stringify(document_model).replace(/&/g, '%26').replace(/;/g, '.');
  },
  
  inject_serialized_document : function(model) {
    for(partial in model) {
      this.append_document_partial(model[partial].type, model[partial]);
    }
  },
  
  append_document_partial : function(id, data) {
    container_id = PartialRegistry.to_s(id);
    behaviour = PartialRegistry.init_behaviour(id);
    
    if(container_id && behaviour) {
      partial = jQuery(this.document_partials[container_id]).attr('id', ++this.document_sequence);
      jQuery(this.document).append(partial);
      partial.data('behaviour', behaviour);
      behaviour.apply(partial, data);
    }
  },

  /*private*/
    
  _all_document_partials : function() {
    return jQuery(this.document).find(this.document_partial);
  }
});