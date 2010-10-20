require 'spec_helper'
require 'ip_location'

describe ClicksAgregator do
  
  before(:each) do
    @short_url = Factory.create(:short_url)
  end
  
  context 'summarize_all_clicks' do
    
    it 'can not do anything' do
      ClicksAgregator.summarize_all_clicks(@short_url.id).should be_empty
    end
    
    it 'collect all clicks' do
      clicks = []
      35.times { clicks << Factory.build(:click_two,   :short_url => @short_url, :created_at => 3.day.ago.to_time) }
      5.times  { clicks << Factory.build(:click_three, :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      5.times  { clicks << Factory.build(:click_two,   :short_url => @short_url, :created_at => 1.day.ago.to_time) }
      45.times { clicks << Factory.build(:click_three, :short_url => @short_url, :created_at => 1.day.ago.to_time) }
      10.times { clicks << Factory.build(:click_two,   :short_url => @short_url, :created_at => Time.now)          }
      
      clicks.each { |click| IpLocation.resolve_location_for(click).save }
      
      s_clicks = ClicksAgregator.summarize_all_clicks(@short_url.id)
      
      s_clicks.should_not be_nil
      s_clicks.size.should == 4
    end
    
  end
  
  context 'summarize_clicks_for' do
    
    it 'can not do anything' do
      ClicksAgregator.summarize_clicks_for(@short_url.id, Time.now.to_date).should be_empty
    end
    
    it 'calculate all clicks around two days' do
      
      clicks = []
      15.times { clicks << Factory.build(:click_two,   :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      25.times { clicks << Factory.build(:click_three, :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      10.times { clicks << Factory.build(:click_two,   :short_url => @short_url, :created_at => Time.now)          }
      
      clicks.each { |click| IpLocation.resolve_location_for(click).save }
      
      s_clicks = ClicksAgregator.summarize_clicks_for(@short_url.id, 2.day.ago.to_date)
      s_clicks.should_not be_nil
      s_clicks.size.should == 2
      
      from_moscow, from_kiev = s_clicks[0], s_clicks[1]
      
      from_moscow.city.name.should == 'Moscow'
      from_moscow.clicks.should    == 25
      from_moscow.percent.should   == '62.50'
      
      from_kiev.city.name.should   == 'Kiev'
      from_kiev.clicks.should      == 15
      from_kiev.percent.should     == '37.50'
      
      # Clicks already calculated
      lambda { ClicksAgregator.summarize_clicks_for(@short_url.id, 2.day.ago.to_date) }.should raise_error
    end
    
  end
end