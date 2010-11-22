# == Schema Info
#
# Table name: short_urls
#
#  id           :integer(4)      not null, primary key
#  campaign_id  :integer(4)
#  clicks_count :integer(4)      not null, default(0)
#  description  :text
#  origin       :string(255)     not null
#  short        :string(255)     not null
#  title        :string(255)
#  created_at   :datetime
#  updated_at   :datetime

require 'spec_helper'

describe ShortUrl do
  
  it 'should be valid' do
    ShortUrl.new(:origin=>'ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'http://ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'https://ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'ftp://ya.ru/file').valid?.should be_true
    ShortUrl.new(:origin=>'http://').valid?.should be_false
    ShortUrl.new(:origin=>'httppss://').valid?.should be_false
    ShortUrl.new(:origin=>'http://httppss://').valid?.should be_false
    
    url = ShortUrl.new(:origin=>'ya.ru')
    url.valid?.should be_true
    url.origin.eql? 'http://ya.ru'
  end
  
  describe "with AASM" do
    context "by default" do
      
      before(:all) do
        ShortUrl.destroy_all
        @short_url = Factory.create(:short_url)
      end
      
      it { @short_url.should be_proxied     }
      it { @short_url.should_not be_pending }
      
      context "with disable! event" do
        specify { @short_url.disable!; @short_url.should be_pending }
      end
      
      context "with enable! event" do
        specify { @short_url.enable!; @short_url.should be_proxied  }
      end
      
    end #end context "by default"
  end # end describe
  
end