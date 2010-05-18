class StatisticsController < ApplicationController
  
  def show
    @short_url = ShortUrl.find(params[:id])
    @total_summarized_clicks = SummarizedClick.summarize_all_by_short_url(@short_url)
    @past_summarized_clicks  = SummarizedClick.find_all_from_now_by_short_url(5, @short_url)
  end
end
