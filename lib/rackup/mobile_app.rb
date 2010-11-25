module Rackup
  class MobileApp < ActionController::Metal
    
    include ActionController::Rendering
    
    append_view_path "#{Rails.root}/app/views"
    
    
    def index
      render
    end
    
  end # end class
end # end module