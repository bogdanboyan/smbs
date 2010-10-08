# == Schema Info
#
# Table name: summarized_clicks
#
#  id           :integer(4)      not null, primary key
#  city_id      :integer(4)
#  country_id   :integer(4)
#  region_id    :integer(4)
#  short_url_id :integer(4)      not null
#  clicks       :integer(4)      not null
#  date         :date            not null
#  percent      :string(255)     not null
#  created_at   :datetime
#  updated_at   :datetime

class SummarizedClick < ActiveRecord::Base
  
  belongs_to :short_url
  belongs_to :city
  belongs_to :region
  belongs_to :country
  
  class << self
    
    def find_last_by_short_url_id(id)
      self.where('short_url_id = ?', id).last # WARNING: Array#last from select * from summarized_clicks where short_url_id = ?
    end


    SUMMARIZE_ALL = <<-SQL
      select count(*) as clicks, substring(count(*)/total*100, 1,5) as percent, city_id, country_id, region_id, short_url_id, date
      from summarized_clicks, (select count(*) as total from summarized_clicks where short_url_id = :id) as total
      where short_url_id = :id group by city_id order by clicks desc
    SQL
    
    # @deprecated
    def summarize_all_by_short_url(id)
      ClicksAgregator.summarize_all_clicks(id)
      self.find_by_sql SUMMARIZE_ALL.gsub(':id', id.to_s)
    end
    
    # @deprecated
    def find_all_from_now_by_short_url(id, days)
      yesterday = cursor_date = (1.day.ago.to_date) and end_date = (yesterday - days)
      day_clicks = []
      
      while cursor_date > end_date do
        day_clicks << SummarizedClick.includes(:city).where('short_url_id = ? and date(date) = ?', id, cursor_date.to_s(:db))
        cursor_date -= 1
      end
      day_clicks.delete([]) unless day_clicks.empty?
      day_clicks.empty? ? nil : day_clicks
    end
  end
end
