class Mobile::ImagesController < ApplicationController
  
  respond_to :js
  
  before_filter :load_mobile_campaign
  
  def index
    @images = @campaign.asset_files.only_images
    
    respond_with do |format|
      format.js do
        render :json => { :html => @images.map { |i| render_to_string :partial => '/mobile/campaigns/image_asset', :object => i }.join }
      end
    end
  end
  
  def create
    image = ImageAsset.new :asset => create_io_stream_from_request
    if image.valid? && image.save && @campaign.asset_files.push!(image)
      render_response render_to_string(:partial => 'mobile/campaigns/image_asset', :object => image)
    else
      render_error_message image
    end
  end


  private
  
  def render_error_message(instance)
    render :json => { :error => instance.errors.full_messages.first }
  end
  
  def render_response(text)
    render :json => { :success => true, :html => text }
  end
  
  def create_io_stream_from_request
    io, filename         = StringIO.new(request.raw_post), (params[:qqfile] || "unknown")
    io.original_filename = filename.gsub((filename.match(/(.+)\.\w+$/)[1] rescue "unknown"), Time.now.to_i.to_s)
    io.content_type      = Mime.const_get((filename.match(/\.(\w+)$/)[1] rescue "unknown").upcase).to_s
    io
  end
  
  def load_mobile_campaign
    @campaign = MobileCampaign.find params[:campaign_id]
  end
end
