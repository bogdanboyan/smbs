class BarcodesController < ApplicationController
  
  def index
    @bar_codes = BarCode.find(:all, :order=> 'id DESC', :limit=> 10)
  end
  
  def show
    @bar_code = BarCode.find(params[:id])
    respond_to do |format|
      format.html  # show.erb
      format.json  { render_response(render_to_string(:partial=> 'bar_code', :object=> @bar_code)) }
    end
  end
  
  def destroy
    begin
      BarCode.destroy(params[:id])
      render_status_200
    rescue
      render_status_404
    end
  end
  
  def download
    path = "public/%s" % BarbyBarcode.image_path({:id => params[:id], :style => 'preview'})
    File.exists?(path) ? send_file(path, :type => 'image/png') : render_status_404
  end
  
  def create_link
    @link_code = LinkCode.new(params[:link_code])
    if @link_code.valid? and @link_code.save
      render_response(render_to_string(:partial=> 'bar_code', :object=> @link_code))
    else
      render_error_message(@link_code)
    end
  end
  
  def create_sms
    @sms_code = SmsCode.new(params[:sms_code])
    if @sms_code.valid? and @sms_code.save
      render_response(render_to_string(:partial=> 'bar_code', :object=> @sms_code))
    else
      render_error_message(@sms_code)
    end
  end
  
  def create_text
    @text_code = TextCode.new(params[:text_code])
    if @text_code.valid? and @text_code.save
      render_response(render_to_string(:partial=> 'bar_code', :object=> @text_code))
    else
      render_error_message(@text_code)
    end
  end
  
  
  private
    def render_error_message(instance)
      render :json=> {:error_message=>instance.errors.full_messages.first}.to_json
    end
    
    def render_response(text)
      render :json=> {:html=> text}.to_json
    end
end
