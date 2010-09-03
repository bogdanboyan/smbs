require 'nokogiri'
require 'open-uri'

module Utils
  
  class GrepMobileResolutions
    
    class << self
      
      def document
        @document ||= Nokogiri::HTML(open('http://cartoonized.net/cellphone-screen-resolution.php'))
      end
      
      def grep
        @grep ||= document.search('//td//td//tr[(((count(preceding-sibling::*))) and parent::*)]//td')
      end
      
      def parse
        @memory, manufacturer, index = [], "", 0
        until index >= grep.size - 1
          (manufacturer = grep[index].text) if not grep[index].text.chop == "\302"
          #@memory << {:manufacturer => manufacturer, :model => grep[index + 1].text, :resolution => grep[index + 2].text}
          puts "Mobile.create({:manufacturer=>'#{manufacturer}', :model=>'#{grep[index + 1].text}', :resolution=>'#{grep[index + 2].text}'})"
          index = index + 3
        end
        @memory
      end
      
    end
    
  end
  
end