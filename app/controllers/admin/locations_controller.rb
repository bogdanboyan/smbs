class Admin::LocationsController < Admin::BaseController
  
  respond_to :json, :only => [ :update_country_display_name, :update_city_display_name ]
  
  
  def countries
    @countries = Country.all
  end
  
  def regions
    @regions = Region.all
  end
  
  def cities
    @cities = City.all
  end
  
  
  def update_country_display_name
    update_and_respond_with_json Country.find params[:id]
  end
  
  def update_city_display_name
    update_and_respond_with_json City.find params[:id]
  end
  
  
  private
  
  def update_and_respond_with_json(location)
    model_name = ActiveModel::Naming.singular(location)
    is_updated = location.update_attribute 'display', params[model_name.to_sym][:display]
    
    render :json => { 
      :success => !!is_updated,
      :error   => location.errors.full_messages.first,
      :html    => render_to_string(:partial => model_name + '.html', :object => location)
    }
  end
  
end
