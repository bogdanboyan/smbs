require 'geoip'

module Location
  class IpDetector

    class << self
  
      def find(ip)
        @geo_db ||= GeoIP::City.new('db/max_mind/GeoLiteCity.dat', :memory, true)
        response = @geo_db.look_up(ip)
      end
  
      def resolve_location_for(click)
        if location = find(click.ip_address) and click.country = find_or_create_country(location)
          click.region   = find_or_create_region(location, click) if location[:region]
          click.city     = find_or_create_city(location, click) if click.region && location[:city]
        
          click.latitude, click.longitude = location[:latitude], location[:longitude]
        
          click.located  = true if click.region && click.city
        else
          Rails.logger.debug "** Can't lookup info for ip address '#{click.ip_address}'"
        end
      
        click
      end
    
    
      private
    
      def find_or_create_country(location)
        Country.find_or_create_by_name_and_code(location[:country_name], location[:country_code3])
      end
    
      def find_or_create_region(location, click)
        Region.find_or_create_by_code_and_country_id(location[:region], click.country.id)
      end
    
      def find_or_create_city(location, click)
        City.find_or_create_by_name_and_country_id_and_region_id(location[:city], click.country.id, click.region.id)
      end

     end # end class << self
  end # end class IpDetector
end