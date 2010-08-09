require File.dirname(__FILE__) + '/../spec_helper'

describe IpLocation do
  it 'should recognize some predefined ip' do
    result = IpLocation.find('77.88.216.22')
    result[:country_code].should eql('UKR')
    result[:country].should      eql('Ukraine')
    result[:region].should       eql('13') 
    result[:city].should         eql('Kiev')
    
    IpLocation.find('127.0.0.1').to_json.should eql("{}")
  end
  
  it 'should recognize location from click' do
    click = Factory.create(:click_two)
    IpLocation.resolve_location_for(click).should be_true
    click.country.code.should eql('UKR')
    click.city.name.should eql('Kiev')
  end
end