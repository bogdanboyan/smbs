class ClicksAgregator
  class << self

    def summarize_all_clicks(short_url_id)
      s_clicks     = []
      last_s_click = SummarizedClick.find_last_by_short_url_id(short_url_id) and end_date = last_s_click.date + 1

      (click = Click.find_by_short_url_id(short_url_id) and end_date = click.created_at) if not end_date

      begin_date, cursor_date = 1.day.ago.to_date, end_date.try(:to_date)
      if begin_date && cursor_date
        while begin_date >= cursor_date do
          s_clicks << summarize_clicks_for(short_url_id, cursor_date)
          cursor_date += 1
        end
      else
        Rails.logger.info("** Can't agregate statistic for short_url(%d)" % short_url_id)
      end

      s_clicks.compact.flatten
    end

    SUMMARIZE_CLICKS = <<-SQL
      select count(*) as clicks, substring(count(*)/total*100, 1,5) as percent, city_id, country_id, region_id, short_url_id, created_at as date
      from clicks, (select count(*) as total from clicks where short_url_id = :id and date(created_at) = ':date') as total
      where short_url_id = :id and date(created_at) = ':date' group by city_id order by clicks desc
    SQL

    def summarize_clicks_for(short_url_id, date, persist = true)
      SummarizedClick.exists?(:short_url_id => short_url_id, :date => date.to_s(:db)) and raise "Statistic is already summarized (short_url.id=%d, date=%s" % [short_url_id, date.to_s]
      # do agregation
      if Click.where('short_url_id = ? and date(created_at) = ?', short_url_id, date.to_s(:db)).limit(1)
        s_clicks = SummarizedClick.find_by_sql SUMMARIZE_CLICKS.gsub(':id', short_url_id.to_s).gsub(':date', date.to_s(:db))
        s_clicks.each {|s_click| SummarizedClick.create(s_click.attributes) } if persist
        s_clicks
      end
    end
    
    def summarize_today_clicks(short_url_id, persist = false)
       summarize_clicks_for(short_url_id, Time.now.to_date, persist)
    end

  end # class << self
end

# mysql> select count(*) as clicks, concat(substring(count(*)/total*100, 1,4),'%') as percent, city_id, country_id, region_id from clicks, (select count(*) as total from clicks where short_url_id = 1 and date(created_at) = '2010-05-03') as total where short_url_id = 1 and date(created_at) = '2010-05-03' group by city_id order by clicks desc;
# +--------+---------+---------+------------+-----------+
# | clicks | percent | city_id | country_id | region_id |
# +--------+---------+---------+------------+-----------+
# |      6 | 75.0%   |    NULL |       NULL |      NULL | 
# |      1 | 12.5%   |       1 |          1 |         1 | 
# |      1 | 12.5%   |       2 |          1 |         2 | 
# +--------+---------+---------+------------+-----------+
# 3 rows in set (0.00 sec)
# 
# mysql>