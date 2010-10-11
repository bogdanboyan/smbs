# encoding: utf-8
require 'spec_helper'

describe QrCodesHelper do
  
  include QrCodesHelper
  
  it 'should slice ascii characters' do
    code  = TextCode.new(:text => 'Ruby on Rails is a breakthrough in lowering the barriers of entry to programming.')
    title = qr_code_title(code)
    title.should == 'Ruby on Rails is a breakthrough ...'
  end
  
  it 'should slice no-ascii characters' do
    code  = TextCode.new(:text => 'Для тех, кто только помыл машину, а через пол часа пошел, сука, дождь')
    title = qr_code_title(code)
    title.to_s.should == 'Для тех, кто только помыл машину...'
  end
  
  it 'should render right names' do
    code  = LinkCode.new(:origin => 'korrespondent.net')
    title = qr_code_title(code)
    title.should == 'korrespondent.net'
  end
  
end