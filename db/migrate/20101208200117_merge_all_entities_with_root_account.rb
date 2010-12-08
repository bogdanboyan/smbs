class MergeAllEntitiesWithRootAccount < ActiveRecord::Migration
  def self.up
    yamco = Account.find_by_kind_of('yamco')
    
    yamco.short_urls << ShortUrl.all
    yamco.mobile_campaigns << MobileCampaign.all
    yamco.bar_codes << BarCode.all
  end

  def self.down
  end
end
