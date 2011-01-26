class Admin::LocationsController < Admin::BaseController 
  
  def countries
    @countries = Country.all
  end
  
  def regions
    @regions = Region.all
  end
  
  def cities
    @cities = City.all
  end
  
end
