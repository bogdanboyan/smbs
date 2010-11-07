require 'geoip'

module IpLocation
  
  class << self
  
    def find(ip)
      @geo_db ||= GeoIP::City.new('db/max_mind/GeoLiteCity.dat', :memory, true)
      response = @geo_db.look_up(ip)
    end
  
    def resolve_location_for(click)
      if location = find(click.ip_address) and click.country  = Country.find_or_create_by_name_and_code(location[:country_name], location[:country_code3])
        click.region   = Region.find_or_create_by_code_and_country_id(location[:region], click.country.id) if location[:region]
        click.city     = City.find_or_create_by_name_and_country_id_and_region_id(location[:city], click.country.id, click.region.id) if click.region && location[:city]
        click.latitude, click.longitude = location[:latitude], location[:longitude]
        click.located  = true if click.region && click.city
      else
        Rails.logger.warn("Can't lookup ip: " + click.ip_address)
      end
      
      click
    end

   end # end class << self
end