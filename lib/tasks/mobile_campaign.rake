#encoding: utf-8
require 'highline/import'

namespace :mobile_campaign do
  
  desc 'wizard: move mobile campaign to another account'
  task :change_account => :environment do
    
    mobile_campaign, account, user = nil
    
    # wizard steps
    
    ask_mobile_campaign_id = -> do
      campaing_id = ask('Enter mobile_campaigns id: ') { |q| q.validate = /\d+/ }

      if not (MobileCampaign.exists?(campaing_id) && mobile_campaign = MobileCampaign.find(campaing_id))
        say("Couldn't find MobileCampaign with ID=#{campaing_id}")
        ask_mobile_campaign_id.call
        
      else
        choose do |menu|
          menu.prompt = "You select mobile_campaign with title '#{mobile_campaign.title}'. Correct? "
          menu.choice(:yes) {}
          menu.choice(:no)  { ask_mobile_campaign_id.call  }
        end
        
      end
    end
    
    ask_account_id = -> do
      account_id = ask('Enter new account id: ') { |q| q.validate = /\d+/ }
      
      if not (Account.exists?(account_id) && account = Account.find(account_id))
        say("Couldn't find Account with ID=#{account_id}")
        ask_account_id.call
        
      elsif not user = account.users.first
        say("This account has not users! You can't move mobile_campaign to empty user")
        ask_account_id.call
        
      else
        choose do |menu|
          menu.prompt = "Move mobile_campaign '#{mobile_campaign.title}' to account '#{account.title}' (#{user.email}). Correct? "
          menu.choice(:yes) {}
          menu.choice(:no) { ask_account_id.call }
        end
        
      end
    end
    
    # run wizard
    ask_mobile_campaign_id.call
    ask_account_id.call
    
    # run migration
    ActiveRecord::Base.transaction do
      [mobile_campaign, mobile_campaign.short_url].compact.each do |sibling|
        sibling.account = account
        sibling.user    = user
        sibling.save!
      end
    end
    
    say("mobile_campaign '#{mobile_campaign.title}' moved to new account '#{account.title}'")
  end
  
end