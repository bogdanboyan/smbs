class StatisticsController < ApplicationController
  
  def show
    @short_url = ShortUrl.find(params[:id])
    # WARNING: SQL INJECTION!!!
    #@total_summarized_clicks = SummarizedClick.summarize_all_by_short_url(params[:id])
    #@past_summarized_clicks  = SummarizedClick.find_all_from_now_by_short_url(params[:id], 5)
  end
end
