module DataSource
  class Shortener
    
    def clicks(id, params={})
      {
        :status => 'ok', :reqId => 0,
        :table =>
          {
            :cols => [ {:id => '1', :label => 'Дата', :type => 'string'}, {:id => '2', :label => 'Посещений', :type => 'number'} ],
            :rows => fetch_data(id),
          }
      }
    end
    
    private
    
    def fetch_data(id)
      rows, all_clicks = [], SummarizedClick.find_all_by_short_url_id(id)
      
      all_clicks.each do |report|
        #[ {:c => [{:v => '2004'}, {:v => 400}]}, {:c => [{:v => '2005'}, {:v => 500}]} ]
        rows << {:c => [ {:v => date_field(report.date)}, {:v => report.clicks} ]}
      end
      
      rows
    end
    
    def date_field(date)
      I18n.localize(date, :format => :short)
    end
    
  end # class
end # module