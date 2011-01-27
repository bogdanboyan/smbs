module Location
  
  class CityDictionary
  
    SYNONYMS_MAP = {
      #'generic_name' => 'synonyms'
      'Lvov'    => 'Lviv',
      'Kharkov' => 'Kharkiv'
    }.freeze
    
    
    class << self
      
      # def migrate
      # end
      
      # def merge_duplications!
      # end
      
      def has_synonym?(city_name)
        city_name != replace(city_name)
      end
      
      def replace(city_name)
        SYNONYMS_MAP.each_pair do |generic_name, synonyms|
          return generic_name if city_name == synonyms
        end
        
        city_name
      end
      
      def remap_city_synonyms!
        SYNONYMS_MAP.each_pair do |generic_name, synonyms|
          remap_city_synonym!(generic_name, synonyms)
        end
      end
      
      def remap_city_synonym!(generic_name, synonyms)
        generic_city  = City.where(:name => generic_name).first
        
        City.where(:name => synonyms).first.clicks.each do |dispersion_click|
          dispersion_click.country = generic_city.country
          dispersion_click.city    = generic_city
          dispersion_click.region  = generic_city.region
          
          dispersion_click.save! # at now this isn't dispersion entity
        end
      end
      
    end
  
  end
  
end