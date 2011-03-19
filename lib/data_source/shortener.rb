# encoding: utf-8
require 'location'

module DataSource
  class Shortener
    
    def clicks(id, params={})
      {
        :cols => [ {:id => '1', :label => 'Дата', :type => 'string'}, {:id => '2', :label => 'Посещений', :type => 'number'} ],
        :rows => fetch_clicks_data(id),
      }
    end
    
    def regions(id, params={})
      {
        :cols => [ {:id => '1', :label => 'Город', :type => 'string'}, {:id => '2', :label => 'Посещений', :type => 'number'} ],
        :rows => fetch_regions_data(id),
      }
    end
    
    
    private
    
    def fetch_clicks_data(id)
      reduced_data, clicks_map = {}, SummarizedClick.where(:short_url_id => id)
      
      # reduce clicks for summarized_clicks
      clicks_map.reduce(reduced_data) do |memo, summarized_click|
        memo[summarized_click.date] = summarized_click.clicks + (memo[summarized_click.date] || 0)
        memo
      end
      
      # reduce TODAY clicks
      today_clicks = Click.where(["short_url_id = ? AND DATE(created_at) = ?", id, Date.today]).count
      reduced_data[Date.today] = today_clicks if today_clicks > 0
      
      reduced_data.map { |report| {:c => [ {:v => date_field(report.first)}, {:v => report.last} ] } }
    end
    
    def fetch_regions_data(id)
      reduced_data, clicks_map = {}, SummarizedClick.where(:short_url_id => id)
      
      clicks_map.each do |summarized_click|
        if not city = summarized_click.city.try(:display)
          city = Location::CityDictionary.replace_and_get_diplay(summarized_click.city.try(:name)) # replace if city name is synonym
          city ||= "Украина*"
        end
        
        if reduced_data.has_key?(city) 
          reduced_data[city] += summarized_click.clicks
        else
          reduced_data[city] = summarized_click.clicks
        end
      end
      
      reduced_data.map {|city, clicks| {:c => [ {:v => city}, {:v => clicks} ]} }
    end
    
    def date_field(date)
      I18n.localize(date, :format => :long)
    end
    
  end # class
end # module