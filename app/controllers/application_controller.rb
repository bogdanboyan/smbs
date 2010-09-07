class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  include ExceptionNotification::Notifiable
  #include ExceptionNotification::ConsiderLocal
  
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def self.bot_request?(request)
    request.env['HTTP_USER_AGENT'] =~ /\b(Googlebot|msnbot|Slurp)\b/i
  end

  def bot_request?
    self.class.bot_request?(request)
  end
  
  def render_status_200
    render :text => "OK", :status => 200
  end
  
  def render_status_404
    render :text => "Not found", :status => 404
  end
  
end
