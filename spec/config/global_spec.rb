require 'spec_helper'

describe Global do
  
  describe 'development env' do
    
    subject {  Global.configuration('development') }
    
    its('host')      { should == 'yamco.local'      }
    its('host_mobi') { should == 'yamco.mobi.local' }
    
    # before(:all) { @global = Global.configuration }
    # 
    # specify 'hosts' do
    #   @global.host.should      == 'yamco.local'
    #   @global.host_mobi.should == 'yamco.mobi.local'
    # end
  end
  
  describe 'production env' do
    
    subject { @configuration ||= Global.reload!('production') }
    
    its('host')      { should == 'yam.co.ua'  }
    its('host_mobi') { should == 'yamco.mobi' }
    
    
    # before(:all) do 
    #   Global.reload!('production')
    #   @global = Global.configuration
    # end
    # 
    # specify 'hosts' do
    #   @global.host.should      == 'yam.co.ua'
    #   @global.host_mobi.should == 'yamco.mobi'
    # end
    
  end
end
