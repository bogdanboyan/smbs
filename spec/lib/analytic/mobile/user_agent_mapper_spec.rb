require 'spec_helper'
require 'analytic/mobile'

module Analytic::Mobile
  
  describe UserAgentMapper do
    
    context 'with map method' do
      
      before(:all) do
        @user_agent = Factory.create :nokia_e51_user_agent
        @mobile     = Factory.create :nokia_e51
      end
      
      it 'should return existing Mobile instance' do
        mobile = UserAgentMapper.map @user_agent
        
        mobile.should_not be_nil
        mobile.new_record?.should be_false
        
        @user_agent.mobile.should be_nil
      end
      
      it 'should return new Mobile instance' do
        @mobile.destroy
        
        mobile = UserAgentMapper.map @user_agent
        
        mobile.should_not be_nil
        mobile.new_record?.should be_true
        
        @user_agent.mobile.should be_nil
      end
      
    end # end context
    
    context 'with map! method' do
      
      before(:all) do
        @user_agent = Factory.create :nokia_e51_user_agent
        @mobile     = Factory.build  :nokia_e51
      end
      
      it 'should return linked Mobile instance with UserAgent' do
        UserAgentMapper.map! @user_agent
        @user_agent.reload
        
        @user_agent.mobile.should be_an_instance_of(::Mobile)
        @user_agent.mobile.model.should == 'E51'
      end
    end # end context
    
  end # end describe
  
end