class StatisticsController < ApplicationController
  
  def show
    @short_url = ShortUrl.find(params[:id])
    @clicks_report = ClicksReport.new(@short_url)
  end
end
