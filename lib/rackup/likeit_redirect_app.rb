#encoding: utf-8
module Rackup
  class LikeitRedirectApp < AbstractClickableApp
    
    def redirect
      
      location ||= mobile_app_root_path
      
      set_headers :status => 302, :response_body => 'Redirecting...', :location => location
    end
    
  end
end