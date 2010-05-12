require 'net/geoip'

module IpLocation
  
  def self.find(ip)
    @geoip ||= Net::GeoIP.new 'db/max_mind/GeoLiteCity.dat'
    response = {}
    begin
      (response = @geoip[ip]) and (response = make_hashed(response))
    rescue Net::GeoIP::RecordNotFoundError=> e
      # maybe make exception notification
      RAILS_DEFAULT_LOGGER.warn(e)
    end
    response
  end
  
  def self.find_location_for(click)
    location = IpLocation.find(click.ip_address)
    unless location.empty?
      click.country = Country.find_or_create_by_name_and_code(location[:country], location[:country_code])
      click.region  = Region.find_or_create_by_code_and_country_id(location[:region], click.country.id)
      click.city    = City.find_or_create_by_name_and_country_id_and_region_id(location[:city], click.country.id, click.region.id)
      return click.located = true
    end
    return false
  end
  
  private
  
    def self.make_hashed(response)
      hash = {
        :city=> response.city,
        :region=> response.region,
        :country=> response.country_name,
        :country_code=> response.country_code3
      }
    end
end