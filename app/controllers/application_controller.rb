#encoding: utf-8
class ApplicationController < ActionController::Base

  include ApplicationHelper


  protect_from_forgery

  helper :all # include all helpers, all the time


  def render_200_response
    render :text => "OK", :status => 200
  end
  
  def render_404_response
    render :text => "Not found", :status => 404
  end


  protected

  def require_no_user
    redirect_to root_url if current_user
  end
  
  def require_yamco_user
    require_real_current_user(:yamco)
  end
  
  def require_reseller_user
    require_current_user(:reseller)
  end
  
  def require_business_user
    require_current_user(:business)
  end
  
  [:require_real_current_user, :require_current_user].each do |filter|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{filter}(kind_of = nil)                                                                          # def require_current_user(kind_of = nil)
        given_user = send '#{filter}'.gsub('require_', '').to_sym                                           #   given_user = send 'require_current_user'.gsub('require_', '').to_sym
        if !given_user || (kind_of && !given_user.account.is?(kind_of))                                     #   if !given_user || (kind_of && given_user.account.is?(kind_of))
          redirect_to login_url, :notice => "Вы должны быть авторизированы для доступа к этой странице"     #     redirect_to login_url, :notice => "Вы должны быть авторизированы для доступа к этой странице"
        end                                                                                                 #   end 
      end                                                                                                   # end
    RUBY_EVAL
  end

end