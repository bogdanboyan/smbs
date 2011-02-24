require 'spec_helper'

describe Global do
  
  describe 'development env' do
    
    subject {  Global.configuration('development') }
    
    its('host')      { should == 'yamco.local'      }
    its('host_mobi') { should == 'yamco.mobi.local' }
    
  end
  
  describe 'production env' do
    
    subject { @configuration ||= Global.reload!('production') }
    
    its('host')      { should == 'yam.co.ua'  }
    its('host_mobi') { should == 'yamco.mobi' }
    
  end
end
