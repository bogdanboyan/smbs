require 'net/geoip'

module IpLocation
  
  class << self
  
    def find(ip)
      @geoip ||= Net::GeoIP.new 'db/max_mind/GeoLiteCity.dat'
      response = {}
      begin
        (response = @geoip[ip]) and (response = make_hashed(response))
      rescue Net::GeoIP::RecordNotFoundError=> e
        # make exception notification
        RAILS_DEFAULT_LOGGER.warn(e)
      end
    
      response
    end
  
    def resolve_location_for(click)
      location = find(click.ip_address)

      unless location.empty?
        click.country = Country.find_or_create_by_name_and_code(location[:country], location[:country_code])
        click.region  = Region.find_or_create_by_code_and_country_id(location[:region], click.country.id) if click.country
        click.city    = City.find_or_create_by_name_and_country_id_and_region_id(location[:city], click.country.id, click.region.id) if click.country and click.region
        click.located = true
      end

    end
  
    private
  
      def make_hashed(response)
        hash = {
          :city=> response.city,
          :region=> response.region,
          :country=> response.country_name,
          :country_code=> response.country_code3
        }
      end
    
   end # end class << self
end