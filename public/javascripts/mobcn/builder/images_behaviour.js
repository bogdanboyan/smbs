var ImagesBehaviour = PartialBehaviour.extend({
  init : function(type){ this._super(type); },
  
  image_template: "<div class='sortable image' style='width:#{width}; position: relative;'>" +
    "<div class='controls'><div class='remove'>удалить</div><div class='move'>переместить</div></div>" +
    "<img width='100%' src='#{src}'/>" +
    "</div>",


  /* public */
  apply : function(/*JQuery*/ element, /*Object*/ data) { this._super(element);
    this.image_container = element.find('.image_container');
    this.image_container.data('current_width', 100);
    
    // load from document_model
    if(data) {
      $(this.image_container).find('.drag_here').hide();
      for(i in data.value) {
        current_width = data.value[i].width.replace('px', '');
        this.image_container.data('current_width', current_width);
        $(this._image_html(data.value[i].width, data.value[i].path)).appendTo(this.image_container);
      }
    }
    
    // droppable
    image_html_proxy = $.proxy(this._image_html, this);
    this.image_container.droppable({
      hoverClass: "droppable-hover",
      accept: ":not(.ui-sortable-helper)",
      drop: function(event, ui) {
        current_width = $(this).data('current_width');
        $(this).find('.drag_here').hide();
        asset_src = ui.draggable.attr('src').replace('thumbnail', 'view');
        $(image_html_proxy(current_width+'px', asset_src)).appendTo(this);
      }
    });
    
    // sortable
    this.image_container.sortable( { handle: '.move' } );
    
    // slider
    element.find('.image_slider').slider({
      range: "min", 
      value: element.find('.image_container').data('current_width') - 100,
      min: 1, 
      max: 96,
      slide: function(event, ui) {
        current_width = 100 + ui.value;
        element.find('.image_container').data('current_width', current_width);
        element.find('.sortable, .image').css('width', current_width);
      }
    });
    
    
    element.show();
  },
  
  to_object : function(/*JQuery*/ element) {
    assets = [];
    this.image_container.find('.sortable').map(
      function() {
        width      = $(this).css('width');
        src        = $(this).find('img').attr('src');
        parsed_src = src.match(/\/assets\/mobcn\/(\d+)\/\d+\.(\w+)/);
        assets.push({width:width, asset_id:parsed_src[1], style:parsed_src[2], path:src});
      });
    
    this.partial_model.value = assets;
    return this.partial_model;
  },
  
  
  /*private*/
      _image_html : function(width, src) {
        return this.image_template.replace("#{width}", width).replace("#{src}", src);
      }
});


ImagesBehaviour.Initializer = {
  init : function() {
    // remove image
    $('.image_container').find('.remove').live('click', function() {
      if(confirm('Вы уверены что хотите удалить изображение?')) {
        sortable = $(this).parents('.sortable');
        if(sortable.parent().children().size() == 2) sortable.parent().find('.drag_here').show();
        sortable.remove();
      }
    });
  }
};