module StatisticsHelper
  
  def statistic_is_unavailable
    '<p>На данный момент статистика по ресурсу не доступна</p>'
  end
  
  def statistic_for_cities(summarized_clicks)
    first_five = summarized_clicks[0..4]
    first_five.map{|click| "#{city_name(click)} <em>#{number_to_percentage(click.percent, :precision => 0)}</em>"}.join(', ')
  end
  
  def total_clicks(summarized_clicks)
    total = 0
    summarized_clicks.map{|summarized_click| total += summarized_click.clicks} and total
  end
  
  def city_name(click)
    click.city || "Другие города"
  end
end
