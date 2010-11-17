require 'shortener'

class ShortenersController < ApplicationController
  
  def index
    @short_urls = ShortUrl.where(:current_state => 'proxied').order('id DESC')
  end
  
  def show
    @short_url = ShortUrl.find(params[:id])
    respond_to do |format|
      format.html # show.erb
      format.json  { render :json => {:html=> render_to_string(:partial=> 'short_url', :object=> @short_url)} }
    end
  end
  
  def create
    @short_url = ShortUrl.new(params[:short_url])
    if @short_url.valid?
      @short_url.short = Shortener.get_basemade_value(ShortSequence.create.id)

      @short_url.save

      result = {:html=> render_to_string(:partial=> 'short_url', :object=> @short_url)}
    else
      result = {:error_message=> @short_url.errors.full_messages.first}
    end
    render :json => result
  end
  
  def destroy
    @short_url = ShortUrl.find(params[:id]) and @short_url.disable!
    
    redirect_to :back
  end
  
end