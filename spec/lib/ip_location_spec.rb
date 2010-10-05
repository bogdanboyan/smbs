require File.dirname(__FILE__) + '/../spec_helper'

describe IpLocation do
  it 'should recognize some predefined ip' do
    result = IpLocation.find('77.88.216.22')
    
    result[:country_code3].should  == 'UKR'
    result[:country_name].should   == 'Ukraine'
    result[:region].should         == '13' 
    result[:city].should           == 'Kiev'
    result[:latitude].to_s.should  == '50.4333000183105'
    result[:longitude].to_s.should == '30.5167007446289'
    
    IpLocation.find('127.0.0.1').should be_nil
    IpLocation.find('127.0.0.1').to_json.should eql("null")
  end
  
  it 'should recognize location from click' do
    click = Factory.create(:click_two)
    IpLocation.resolve_location_for(click).should be_true
    click.save! and click.reload
    
    click.country.code.should     == 'UKR'
    click.city.name.should        == 'Kiev'
    click.latitude.should         == 50.433300.to_d
    click.longitude.should        == 30.516701.to_d
  end
end