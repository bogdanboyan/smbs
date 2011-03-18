require 'spec_helper'
require 'location'

module Location
  
  describe CityDictionary do
    
    before(:all) do 
      @ukraine     = Factory.build :ukraine
      @lvov_region = Factory.build :lvov_region
      @kiev_region = Factory.build :kiev_region
      @shortener   = Factory.build :short_url
    end
    
    it 'should has_synonym' do
      CityDictionary.has_synonym?("Kiev").should be_false
      CityDictionary.has_synonym?("Lviv").should be_true
    end
    
    it 'should replace' do
      CityDictionary.replace("Kiev").should == "Kiev"
      CityDictionary.replace("Lvov").should == "Lvov"
      CityDictionary.replace("Lviv").should == "Lvov"
    end
    
    it 'should relpace multiple synonyms' do
      CityDictionary.replace("Dnipropetrovsk").should  == "Dnepropetrovsk"
      CityDictionary.replace("Dniepropetrovsk").should == "Dnepropetrovsk"
    end
    
    it 'should remap_city_synonyms!' do
      lviv = City.create :name => 'Lviv', :country => @ukraine, :region => @lvov_region
      10.times { lviv.clicks << Click.create({ :ip_address => '127.0.0.1', :short_url => @shortener })  }
      
      lvov = City.create :name => 'Lvov', :country => @ukraine, :region => @lvov_region
      
      CityDictionary.remap_city_synonym!('Lvov', 'Lviv')
      
      lviv.reload and lviv.clicks.should have(0).items
      lvov.reload and lvov.clicks.should have(10).items
    end
    
    it 'should create generic name and remap synonym to generic name' do
      chernihiv = City.create :name => 'Chernihiv', :country => @ukraine, :region => @lvov_region
      23.times { chernihiv.clicks << Click.create({ :ip_address => '127.0.0.1', :short_url => @shortener }) }
      
      CityDictionary.remap_city_synonym!('Chernihov', 'Chernihiv')
      
      chernihiv.reload and chernihiv.clicks.should have(0).items
      City.where(:name => 'Chernihov').first.clicks.should have(23).items
    end
    
  end
  
end

