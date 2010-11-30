class Mobile::AssetsController < ApplicationController

  def upload_image
    image = ImageAsset.new :asset => create_io_stream_from_request
    if image.valid? && image.save
      render_response render_to_string(:partial => 'mobile/campaigns/image', :object => image)
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

end
