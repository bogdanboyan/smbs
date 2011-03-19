module Location
  
  class CityDictionary
  
    SYNONYMS_MAP = {
      #'generic_name' => 'synonyms'
      'Lvov'           => 'Lviv',
      'Kharkov'        => 'Kharkiv',
      'Dnepropetrovsk' => %w{Dnipropetrovsk Dniepropetrovsk},
      'Chernogiv'      => 'Chernihiv'
    }.freeze
    
    
    class << self
      
      def has_synonym?(city_name)
        city_name != replace(city_name)
      end
      
      def replace(city_name)
        SYNONYMS_MAP.each_pair do |generic_name, synonyms|
          if synonyms.respond_to?(:include?) && synonyms.include?(city_name)
            return generic_name
          else
            return generic_name if city_name == synonyms
          end
        end
        
        city_name
      end
      
      def replace_and_get_diplay(city_name)
        return if city_name.nil?
        city_name = replace(city_name)
        City.connection.select_value("SELECT display FROM cities WHERE name = '#{city_name}' limit 1") || city_name
      end
      
      def remap_city_synonyms!
        SYNONYMS_MAP.each_pair do |generic_name, synonyms|
          remap_city_synonym!(generic_name, synonyms)
        end
      end
      
      def remap_city_synonym!(generic_name, synonyms)
        generic_city  = City.find_or_create_by_name(generic_name)
        
        mapred_metthod = lambda do |synonym|
          City.where(:name => synonyms).first.clicks.each do |dispersion_click|
            dispersion_click.country = generic_city.country
            dispersion_click.city    = generic_city
            dispersion_click.region  = generic_city.region

            dispersion_click.save! # after that this isn't a dispersion entity
          end
        end
        
        synonyms.respond_to?(:each) ? synonyms.each { |synonym| mapred_metthod.call(synonym) } : mapred_metthod.call(synonyms)
      end
      
    end
  
  end
  
end