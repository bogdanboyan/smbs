# == Schema Info
# Schema version: 20100512175856
#
# Table name: bar_codes
#
#  id         :integer(4)      not null, primary key
#  level      :string(255)
#  origin     :string(255)
#  source     :text(16777215)
#  tel        :string(255)
#  text       :string(255)
#  type       :string(255)     not null
#  version    :integer(4)
#  created_at :datetime
#  updated_at :datetime

require File.dirname(__FILE__) + '/../spec_helper'

describe SmsCode do
  
  it 'should be valid' do
    SmsCode.new(:tel=>'').valid?.should be_false
    SmsCode.new(:tel=>'+380978053300').valid?.should be_true
    SmsCode.new(:tel=>'text').valid?.should be_false
  end
end

describe LinkCode do
  
  it 'should be valid' do
    LinkCode.new(:origin=>'').valid?.should be_false
    LinkCode.new(:origin=>'yandex.ru').valid?.should be_true
  end
end