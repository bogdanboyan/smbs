class BarcodesController < ApplicationController
  
  def index
    @bar_codes = BarCode.find(:all, :order=> 'id DESC', :limit=> 10)
  end
  
  def show
    @bar_code = BarCode.find(params[:id])
    # respond_to do |format|
    #   format.svg { render :text=> @bar_code.source }
    # end
  end
  
  def create_link
    @link_code = LinkCode.new(params[:link_code])
    if @link_code.valid? and @link_code.save
      render_html(render_to_string(:partial=> 'bar_code', :object=> @link_code))
    else
      render_error_message(@link_code)
    end
  end
  
  def create_sms
    @sms_code = SmsCode.new(params[:sms_code])
    if @sms_code.valid? and @sms_code.save
      render_html(render_to_string(:partial=> 'bar_code', :object=> @sms_code))
    else
      render_error_message(@sms_code)
    end
  end
  
  def create_text
    @text_code = TextCode.new(params[:text_code])
    if @text_code.valid? and @text_code.save
      render_html(render_to_string(:partial=> 'bar_code', :object=> @text_code))
    else
      render_error_message(@text_code)
    end
  end
  
  
  private
    def render_error_message(instance)
      render :json=> {:error_message=>instance.errors.full_messages.first}.to_json
    end
    
    def render_html(text)
      render :json=> {:html=> text}.to_json
    end
end
