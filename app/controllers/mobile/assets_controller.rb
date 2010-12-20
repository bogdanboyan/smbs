class Mobile::AssetsController < ApplicationController

  before_filter :require_current_user
  

  def upload_image
    image = ImageAsset.new({:asset => create_io_from_post_raw})
    if image.valid? && image.save
      render_response(render_to_string(:partial => 'mobile/campaigns/image', :object => image))
    else
      render_error_message(image)
    end
  end
  
  private
  
    def render_error_message(instance)
      render :json=> {:error => instance.errors.full_messages.first}.to_json
    end
    
    def render_response(text)
      render :json=> {:success => true, :html=> text}.to_json
    end
    
    def create_io_from_post_raw
      io, filename         = StringIO.new(request.raw_post), (params[:qqfile] || "unknown")
      io.original_filename = filename.gsub((filename.match(/(.+)\.\w+$/)[1] rescue "unknown"), Time.now.to_i.to_s)
      io.content_type      = Mime.const_get((filename.match(/\.(\w+)$/)[1] rescue "unknown").upcase).to_s
      io
    end


end
