require 'spec_helper'
require 'analytic/mobile'

module Analytic::Mobile
  
  describe UserAgentDetector do
    
    context 'with parse method' do
      
      specify 'fetch valid info' do
        data = UserAgentDetector.parse 'x-wap-profile' => 'http://nds1.nds.nokia.com/uaprof/NE51-1r100.xml'
      
        data.should have(5).items
      
        data[:manufacturer].should == 'Nokia'
        data[:model].should        == 'E51'
        data[:width].should        == '240'
        data[:height].should       == '320'
        data[:resolution].should   == '240 x 320'
      end
      
      specify 'unknown x_wap_profile' do
        data = UserAgentDetector.parse 'x-wap-profile' => 'http://nds1.nds.nokia.com/uaprof/NEXXXX-1r100.xml'
        
        data.should be_empty
      end
    end
    
  end
  
end