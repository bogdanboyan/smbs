module StatisticsHelper
  
  def regions_data(statistic)
    statistic.map{|pie| "#{pie[:region]} <em>#{pie[:persent]}</em>"}.join(', ')
  end
end
