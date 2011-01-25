# encoding: utf-8
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
      merged_reports, reports = {}, SummarizedClick.find_all_by_short_url_id(id)
      
      reports.reduce(merged_reports) do |memo, report|
        memo[report.date] = report.clicks + (memo[report.date] || 0)
        memo
      end
      
      merged_reports.map { |report| {:c => [ {:v => date_field(report.first)}, {:v => report.last} ] } }
    end
    
    def fetch_regions_data(id)
      rows, reports = {}, SummarizedClick.find_all_by_short_url_id(id)
      
      reports.each do |report|
        city = report.city.try(:display) || report.city.try(:name) || "Украина*"
        rows.has_key?(city) ? rows[city] += report.clicks : rows[city] = report.clicks
      end
      
      rows.map {|city, clicks| {:c => [ {:v => city}, {:v => clicks} ]} }
    end
    
    def date_field(date)
      I18n.localize(date, :format => :long)
    end
    
  end # class
end # module