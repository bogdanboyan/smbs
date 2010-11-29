module Rackup
  class AbstractMobileMetalController < ActionController::Metal
    
    include ActionController::Rendering
    include AbstractController::Helpers
    
    append_view_path "#{Rails.root}/app/views"
    
    helper 'rackup/mobile'
    
  end
end