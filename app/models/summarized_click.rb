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
      self.find(:last, :conditions=> ['short_url_id = ?', id])
    end
    
    SUMMARIZE_ALL = <<-SQL
      select count(*) as clicks, concat(substring(count(*)/total*100, 1,4),'%') as percent, city_id, country_id, region_id, short_url_id
      from summarized_clicks, (select count(*) as total from summarized_clicks where short_url_id = :id) as total
      where short_url_id = :id group by city_id order by clicks desc
    SQL
    
    def summarize_all_by_short_url(short_url)
      ClicksAgregator.summarize_all_clicks(short_url)
      self.find_by_sql SUMMARIZE_ALL.gsub(':id', short_url.id.to_s)
    end
    
    def find_all_from_now_by_short_url(days, short_url)
      yesterday = 1.day.ago.to_date and end_date = yesterday - days
      self.find(
        :all, 
        :conditions=>['short_url_id = ? and date(date) <= ? and date(date) >= ?', short_url.id, yesterday.to_s(:db), end_date.to_s(:db)],
        :include=> :city
      )
    end
  end
end
