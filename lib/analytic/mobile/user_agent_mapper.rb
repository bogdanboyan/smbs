module Analytic
  module Mobile
    
    class UserAgentMapper
      
      class << self
        
        def map(user_agent)
          uaprof      = user_agent.profile || user_agent.x_wap_profile
          mobile_info = UserAgentDetector.parse('x-wap-profile' => uaprof)
          
          # puts mobile_info

          (::Mobile.where(mobile_info).first || ::Mobile.new(mobile_info)) unless mobile_info.empty?
        end
        
        def map!(user_agent)
          user_agent.mobile = map(user_agent)
          user_agent.save!
        end
        
      end
      
    end # end UserAgentMapper
    
  end # end Moble module
end # end Analytic module