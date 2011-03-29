class BarcodesController < ApplicationController
  
  before_filter :require_current_user
  
  
  def index
    @bar_codes = current_account.bar_codes
      .order('id DESC')
      .paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @bar_code = current_account.bar_codes.find(params[:id])
    respond_to do |format|
      format.html  # show.erb
      format.json  { render_response(render_to_string(:partial=> 'bar_code', :object=> @bar_code)) }
    end
  end
  
  def destroy
    begin
      current_account.bar_codes.find(params[:id]).destroy
      render_200_response
    rescue
      render_404_response
    end
  end
  
  def download
    path = "public/%s" % BarbyBarcode.image_path({:id => params[:id], :style => 'preview'})
    File.exists?(path) ? send_file(path, :type => 'image/png') : render_404_response
  end
  
  def create_link
    @link_code = LinkCode.new(params[:link_code])
    if @link_code.valid? and single_save(@link_code)
      render_response render_to_string(:partial => 'bar_code', :object => @link_code)
    else
      render_error_message(@link_code)
    end
  end
  
  def create_sms
    @sms_code = SmsCode.new(params[:sms_code])
    if @sms_code.valid? and single_save(@sms_code)
      render_response render_to_string(:partial => 'bar_code', :object => @sms_code)
    else
      render_error_message(@sms_code)
    end
  end
  
  def create_text
    @text_code = TextCode.new(params[:text_code])
    if @text_code.valid? and single_save(@text_code)
      render_response render_to_string(:partial => 'bar_code', :object => @text_code)
    else
      render_error_message(@text_code)
    end
  end
  
  
  private
  
  def single_save(qr_code)
    qr_code.account = current_account
    qr_code.user    = current_user
    
    qr_code.update_dashboard(:qr_code_created, real_current_user)
    
    qr_code.save
  end
  
  def render_error_message(instance)
    render :json => { :error_message => instance.errors.full_messages.first }
  end
  
  def render_response(text)
    render :json => { :html => text }
  end
end
