require 'spec_helper'
require 'location'

describe ClicksAgregator do
  
  before(:each) do
    @short_url = Factory.create(:short_url)
  end
  
  context 'with summarize_all_clicks should' do
    
    it 'can not do anything' do
      ClicksAgregator.summarize_all_clicks(@short_url.id).should be_empty
    end
    
    it 'collect all clicks' do
      clicks = []
      35.times { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => 3.day.ago.to_time) }
      5.times  { clicks << Factory.build(:moscow_click, :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      5.times  { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => 1.day.ago.to_time) }
      45.times { clicks << Factory.build(:moscow_click, :short_url => @short_url, :created_at => 1.day.ago.to_time) }
      10.times { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => Time.now)          }
      
      clicks.each { |click| Location::IpDetector.resolve_location_for(click).save }
      
      s_clicks = ClicksAgregator.summarize_all_clicks(@short_url.id)
      
      s_clicks.should_not be_nil
      s_clicks.size.should == 4
    end
    
  end
  
  context 'with summarize_clicks_for should' do
    
    it 'can not do anything' do
      ClicksAgregator.summarize_clicks_for(@short_url.id, Time.now.to_date).should be_empty
    end
    
    it 'calculate all clicks around two days' do
      
      clicks = []
      15.times { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      25.times { clicks << Factory.build(:moscow_click, :short_url => @short_url, :created_at => 2.day.ago.to_time) }
      10.times { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => Time.now)          }
      
      clicks.each { |click| Location::IpDetector.resolve_location_for(click).save }
      
      s_clicks = ClicksAgregator.summarize_clicks_for(@short_url.id, 2.day.ago.to_date)
      s_clicks.should_not be_nil
      s_clicks.size.should == 2
      
      from_moscow, from_kiev = s_clicks[0], s_clicks[1]
      
      #from_moscow.city.name.should == 'Moscow'
      from_moscow.clicks.should    == 25
      from_moscow.percent.should   == '62.50'
      
      from_kiev.city.name.should   == 'Kiev'
      from_kiev.clicks.should      == 15
      from_kiev.percent.should     == '37.50'
      
      # Clicks already calculated
      lambda { ClicksAgregator.summarize_clicks_for(@short_url.id, 2.day.ago.to_date) }.should raise_error
    end
    
    it 'calculate today clicks with options "persist = false"' do
      clicks = []
      26.times { clicks << Factory.build(:moscow_click, :short_url => @short_url, :created_at => 1.day.ago.to_time) }
      13.times { clicks << Factory.build(:kiev_click,   :short_url => @short_url, :created_at => Time.now)          }
      
      clicks.each { |click| Location::IpDetector.resolve_location_for(click).save }
      
      s_clicks = ClicksAgregator.summarize_today_clicks(@short_url.id)
      s_clicks.should_not be_nil
      s_clicks.size.should == 1
      #s_clicks.each{ |s_click| s_click.new_record?.should be_true }
      
      from_kiev = s_clicks[0]
      
      from_kiev.city.name.should   == 'Kiev'
      from_kiev.clicks.should      == 13
      from_kiev.percent.should     == '100.0'
    end
    
  end
end