module StatisticsHelper
  
  def statistic_is_unavailable
    '<p>На данный момент статистика по ресурсу не доступна</p>'
  end
  
  def statistic_for_cities(summarized_clicks)
    first_five = summarized_clicks[0..4]
    first_five.map{|click| "#{city_name(click)} <em>#{click.percent}</em>"}.join(', ')
  end
  
  def city_name(click)
    click.city || "Другие города"
  end
end
