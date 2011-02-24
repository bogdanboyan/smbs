class Mobile::ImagesController < ApplicationController
  
  respond_to :js
  
  # fix only for opera browser
  # ActionController::InvalidAuthenticityToken (ActionController::InvalidAuthenticityToken)
  skip_before_filter :verify_authenticity_token, :only => :create
  
  
  before_filter :require_current_user
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
    # opera can receive only text based response vs json => { :success => true }
    render :text => { :error => instance.errors.full_messages.first }.to_json
  end
  
  def render_response(partial)
    # opera can receive only text based response vs json => { :success => true }
    render :text => { :success => true, :html => partial }.to_json
  end
  
  def create_io_stream_from_request
    # if browser send multipart request (opera)
    if params[:qqfile].kind_of?(ActionDispatch::Http::UploadedFile)
      io, filename = StringIO.new(params[:qqfile].tempfile.read), params[:qqfile].original_filename
    else # if browser post raw_post request
      io, filename = StringIO.new(request.raw_post), (params[:qqfile] || "unknown")
    end
    
    io.original_filename = filename.gsub((filename.match(/(.+)\.\w+$/)[1] rescue "unknown"), Time.now.to_i.to_s)
    io.content_type      = Mime.const_get((filename.match(/\.(\w+)$/)[1] rescue "unknown").upcase).to_s
    
    io
  end
  
  def load_mobile_campaign
    @campaign = MobileCampaign.find params[:campaign_id]
  end
end
