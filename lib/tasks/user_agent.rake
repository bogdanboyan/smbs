require 'analytic/mobile'

namespace :user_agent do
  
  desc 'recognize and map user_agent record with mobile device'
  task :map => :environment do
    begin
      UserAgent.where('mobile_id IS NULL AND (profile IS NOT NULL OR x_wap_profile IS NOT NULL)').each do |user_agent|
        Analytic::Mobile::UserAgentMapper.map! user_agent
        puts "-> map user_agent: '%s' with mobile: '%s' " % [user_agent.details, user_agent.mobile.model] if user_agent.mobile
      end
    rescue Exception => exception
       ExceptionNotifier::Notifier.background_exception_notification(exception).deliver
    end
  end
  
end