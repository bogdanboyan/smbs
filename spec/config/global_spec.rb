require 'spec_helper'

describe Global do
  
  context 'with development env' do
    
    before(:all) { @global = Global.configuration }
    
    specify 'hosts' do
      @global.host.should      == 'yamco.local'
      @global.host_mobi.should == 'yamco.mobi.local'
    end
  end
  
  context 'with production env' do
    
    before(:all) do 
      Global.reload!('production')
      @global = Global.configuration
    end
    
    specify 'hosts' do
      @global.host.should      == 'yam.co.ua'
      @global.host_mobi.should == 'yamco.mobi'
    end
    
  end
end
