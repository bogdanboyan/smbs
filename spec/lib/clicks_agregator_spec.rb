require File.dirname(__FILE__) + '/../spec_helper'

describe ClicksAgregator do
  
  describe 'should test summarize_all_clicks' do
    it 'should can not do anything' do
      @short_url = Factory.create(:short_url)
      ClicksAgregator.summarize_all_clicks(@short_url).should be_nil
    end
  end
  
  describe 'should test summarize_clicks_for' do
    it 'should can not do anything' do
      @short_url = Factory.create(:short_url)
      ClicksAgregator.summarize_clicks_for(@short_url, Time.now.to_date).should be_nil
    end
    
    it 'should build summarized_click' do
      @click = Factory.create(:click_one) and @click.created_at = '2010-05-03'.to_datetime and @click.save
      @short_url = @click.short_url
      s_clicks = ClicksAgregator.summarize_clicks_for(@short_url, @short_url.created_at.to_date)
      s_clicks.should_not be_nil and s_clicks.size.should == 1
      s_click = s_clicks.first
      s_click.clicks.should == 1 and s_click.percent.should match('100')
      lambda { ClicksAgregator.summarize_clicks_for(@short_url, @short_url.created_at.to_date)}.should raise_error
    end
  end
end