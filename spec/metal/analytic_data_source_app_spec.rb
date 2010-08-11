require File.dirname(__FILE__) + '/../spec_helper'

describe AnalyticDataSourceApp do
  
  context 'routing context' do
    
    it 'should process /ds requests' do
      ['/ds/shortener/98/clicks'].each do |path|
        response = AnalyticDataSourceApp.call({'PATH_INFO' => path})
        response[0].should == 200
      end
    end
    
  end
end
