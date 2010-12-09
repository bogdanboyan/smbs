class StatisticsController < ApplicationController

  before_filter :require_user

  before_filter :load_short_url
  
  def show
    ClicksAgregator.summarize_all_clicks(@short_url.id)
  end
  
  def details
    @clicks = Click.where(:short_url_id => @short_url).includes(:user_agent).order('id ASC').paginate(:page => params[:page])
  end
  
  
  private
  
  def load_short_url
    @short_url = ShortUrl.find params[:id]
  end
end
