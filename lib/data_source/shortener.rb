module DataSource
  class Shortener
    
    # Who does ClickAgregation?
    
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
      rows, reports = [], SummarizedClick.find_all_by_short_url_id(id)
      
      reports.each do |report|
        rows << {:c => [ {:v => date_field(report.date)}, {:v => report.clicks} ]}
      end
      
      rows
    end
    
    def fetch_regions_data(id)
      rows, reports = {}, SummarizedClick.find_all_by_short_url_id(id)
      
      reports.each do |report|
        city = report.city || "Другие города"
        rows.has_key?(city) ? rows[city] += report.clicks : rows[city] = report.clicks
      end
      
      rows.map {|city, clicks| {:c => [ {:v => city}, {:v => clicks} ]} }
    end
    
    def date_field(date)
      I18n.localize(date, :format => :day_long)
    end
    
  end # class
end # module