require File.dirname(__FILE__) + '/../spec_helper'

describe IpLocation do
  it 'should recognize some predefined ip' do
    IpLocation.find('77.88.216.22').to_json.should eql('{"country_code":"UKR","region":"13","city":"Kiev","country":"Ukraine"}')
    IpLocation.find('127.0.0.1').to_json.should eql("{}")
  end
end