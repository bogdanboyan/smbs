SMBS.Admin = {};

SMBS.Admin.Locations = {
  
  prompt_new_country_display_name: function(country, id) {
    translation = prompt("Укажите перевод названия страны '"+ country +"':","");
    this.submit_display_name("country", id, translation);
  },
  
  prompt_edit_country_display_name: function(country, id) {
    new_display_name = prompt("Укажите новое название страны '"+ country +"':","");
    this.submit_display_name("country", id, new_display_name);
  },
  
  prompt_new_city_display_name: function(city, id) {
    translation = prompt("Укажите перевод города '"+ city +"':","");
    this.submit_display_name("city", id, translation);
  },
  
  prompt_edit_city_display_name: function(city, id) {
    new_display_name = prompt("Укажите новое название города '"+ city +"':","");
    this.submit_display_name("city", id, new_display_name);
  },
  
  
  submit_display_name: function(location, id, display_name) {
    if(display_name) {
      $.ajax({
        type:     'put',
        dataType: 'json',
        url:      '/admin/locations/' + id + '/update_' + location +'_display_name',
        data:     location + '[display]=' + display_name,
        success: function(data) {
          if(data.success) {
            SMBS.Application.show_notice('Новое название было успешно установлено');
            $('#'+id).replaceWith(data.html);
          } else {
            SMBS.Application.show_error(data.error);
          }
        },
        error: function() { SMBS.Application.show_error('Сохранение не может быть выполнено из-за ошибки сети. Попробуйте позже'); }
      });
    } // end if
  } // end submit_city_display_name
};