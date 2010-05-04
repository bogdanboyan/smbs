class ClicksReport
  
  def initialize(short_url)
    @short_url = short_url
  end
  
  def created_at_period
    10
  end
  
  def total_clicks
    @short_url.clicks.count
  end
  
  def total_regions
    [
      {:region=> 'Киев', :persent=> '70%'},
      {:region=> 'Житомир', :persent=> '20%'},
      {:region=> 'Другие регионы', :persent=> '10%'},
    ]
  end
  
  def statistic_for_given_days(days)
    begin_date, report = Time.now, []
    (1..days).each do |range|
      report << statistic_for_given_date(begin_date)
      begin_date = range.day.ago
    end
    report.compact!
  end
  
  private
  
    def statistic_for_given_date(date)
      if @clicks = Click.find(:all, :conditions=>["short_url_id = ? AND DATE(created_at) = ?", @short_url.id, date.to_date.to_s(:db)])
        {:date=> date, :clicks=> @clicks.size, :regions=> total_regions} unless @clicks.empty?
      end
    end
end