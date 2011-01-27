require 'spec_helper'
require 'location'

module Location
  
  describe IpDetector do
  
    it 'should not recognize' do
      IpDetector.find('127.0.0.1').should be_nil
      IpDetector.find('127.0.0.1').to_json.should eql("null")
    end
  
    it 'should recognize country, region, city and geo' do
      result = IpDetector.find('67.215.77.132')
    
      result[:country_code3].should  == 'USA'
      result[:country_name].should   == 'United States'
      result[:region].should         == 'CA' 
      result[:city].should           == 'San Francisco'
      result[:latitude].to_s.should  == '37.789798736572266'
      result[:longitude].to_s.should == '-122.39420318603516'
    end
  
    it 'should recognize only country, region and geo' do
      result = IpDetector.find('194.0.131.18')
    
      result[:country_code3].should  == 'UKR'
      result[:country_name].should   == 'Ukraine'
      result[:region].should         == '13' 
      result[:city].should           == 'Kiev'
      result[:latitude].to_s.should  == '50.43330001831055'
      result[:longitude].to_s.should == '30.516700744628906'
    end
  
    it 'should recognize only country and geo' do
      result = IpDetector.find('178.94.71.150')
    
      result[:country_code3].should  == 'UKR'
      result[:country_name].should   == 'Ukraine'
      result[:latitude].to_s.should  == '49.0'
      result[:longitude].to_s.should == '32.0'
    end
  
    it 'should recognize ukr location click' do
      click = Factory.create(:ukr_click)
      IpDetector.resolve_location_for(click).should be_true
      click.save! and click.reload
    
      click.country.code.should     == 'UKR'
      click.country.name.should     == 'Ukraine'
      click.latitude.should         == 49.0.to_d
      click.longitude.should        == 32.0.to_d
    
      click.located.should          == false
    end
  
    it 'should recognize kiev location click' do
      click = Factory.create(:kiev_click)
      IpDetector.resolve_location_for(click).should be_true
      click.save! and click.reload
    
      click.country.code.should     == 'UKR'
      click.country.name.should     == 'Ukraine'
      click.region.code.should      == '13'
      click.city.name.should        == 'Kiev'
      click.latitude.should         == 50.4333.to_d
      click.longitude.should        == 30.516701.to_d
    
      click.located.should          == true
    end
  
  end # end describe
end