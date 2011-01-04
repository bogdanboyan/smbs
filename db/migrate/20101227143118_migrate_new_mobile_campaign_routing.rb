class MigrateNewMobileCampaignRouting < ActiveRecord::Migration
  
  def self.up
    ShortUrl.all.each do |short_url|
      if short_url.origin.match(/\/mobile\/campaigns\/(\d+)/)
        short_url.update_attribute('origin', "http://#{Global.host_mobi}/mobile_app/campaigns/#{$1}")
      end
    end
  end

end
