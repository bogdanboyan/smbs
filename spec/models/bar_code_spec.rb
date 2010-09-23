# == Schema Info
#
# Table name: bar_codes
#
#  id          :integer(4)      not null, primary key
#  campaign_id :integer(4)
#  level       :string(255)
#  origin      :string(255)
#  source      :text(16777215)
#  tel         :string(255)
#  text        :string(255)
#  type        :string(255)     not null
#  version     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime

require 'spec_helper'

describe SmsCode do
  
  it 'should be valid' do
    SmsCode.new(:tel=>'').valid?.should be_false
    SmsCode.new(:tel=>'+380978053300').valid?.should be_true
    SmsCode.new(:tel=>'text').valid?.should be_false
    
    SmsCode.new(:tel=>'+380978053300', :text=>'ref#').encode_string.should eql("SMSTO:+380978053300:ref#")
    SmsCode.new(:tel=>'+380978053300').encode_string.should eql("SMSTO:+380978053300")
  end
end

describe LinkCode do
  
  it 'should be valid' do
    LinkCode.new(:origin=>'').valid?.should be_false
    LinkCode.new(:origin=>'yandex.ru').valid?.should be_true
    
    lc = LinkCode.new(:origin=>'ya.ru')
    lc.valid?
    lc.encode_string.should eql('http://ya.ru')
  end
end

describe TextCode do
  
  it 'should be valid' do
    TextCode.new(:text=>'simple text').encode_string.should eql('simple text')
  end
end

# phone_call TEL:001
# email SMTP:for_me@g.gl:Yo!:Body