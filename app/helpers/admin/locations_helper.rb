#encoding: utf-8

require 'location'

module Admin::LocationsHelper
  
  def city_display_name_or_synonym(city)
    if Location::CityDictionary.has_synonym?(city.name)
      "синоним города: #{Location::CityDictionary.replace(city.name)}"
    else
      "русское значение: #{create_or_edit_display_name_link(city)}"
    end
  end
  
  def country_display_name(country)
    "русское значение: #{create_or_edit_display_name_link(country)}"
  end
  
  
  private
  
  def create_or_edit_display_name_link(location)
    model_name = ActiveModel::Naming.singular(location)
    if display_name = location.display
      link_to_function display_name, "SMBS.Admin.Locations.prompt_edit_#{model_name}_display_name('#{location.name}', #{location.id})"
    else
      link_to_function "указать", "SMBS.Admin.Locations.prompt_new_#{model_name}_display_name('#{location.name}', #{location.id})"
    end
  end
end
