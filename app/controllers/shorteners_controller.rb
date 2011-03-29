require 'shortener'

class ShortenersController < ApplicationController
  
  before_filter :require_current_user
  
  
  def index
    @short_urls = current_account.short_urls
      .where(:current_state => 'proxied')
      .order('id DESC')
      .paginate(:page => params[:page], :per_page => 10)
  end
  
  def create
    short_url = ShortUrl.new params[:short_url]
    if short_url.valid?
      short_url.short = Shortener.get_basemade_value(ShortSequence.create.id)
      
      short_url.account = current_account
      short_url.user    = current_user
      
      short_url.update_dashboard(:shortener_created, real_current_user)
      
      short_url.save

      result = { :html => render_to_string(:partial=> 'short_url', :object=> short_url) }
    else
      result = { :error_message => short_url.errors.full_messages.first }
    end
    render :json => result
  end
  
  def destroy
    @short_url = current_account.short_urls.find(params[:id]) and @short_url.disable!
    
    redirect_to shorteners_url
  end
  
end