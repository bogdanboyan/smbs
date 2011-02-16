# encoding: utf-8
require 'spec_helper'

module Dashboardable
  
  describe Stringify do
    
    before(:each) do
      @user    = Factory.build(:user)
      @account = Factory.build(:account)
    end
    
    context 'MobileCampaign' do
      
      before(:each) do
        @short_url       = Factory.build(:short_url)
        @mobile_campaign = Factory.build(:mobile_campaign, :user => @user, :account => @account, :short_url => @short_url)
      end
      
      it 'should stringify :page_created' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :page_created)
        
        strf.should == '%s -> %s создал мобильную страаницу "%s"'
        vars.should have(3).items
      end
      
      it 'should stringify :content_changed' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :content_changed)
        
        strf.should == '%s -> %s внес изменения для мобильной страаницы "%s"'
        vars.should have(3).items
      end
      
      it 'should stringify :short_url_assigned' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :short_url_assigned)
        
        strf.should == '%s -> %s добавил короткий адрес %s для мобильной страницы "%s"'
        vars.should have(4).items
      end
      
      it 'should stringify :short_url_generated' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :short_url_generated)
        
        strf.should == '%s -> %s создал короткий адрес %s для мобильной страницы "%s"'
        vars.should have(4).items
      end
      
      it 'should stringify :page_published' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :page_published)
        
        strf.should == '%s -> %s опубликовал мобильную страницу "%s"'
        vars.should have(3).items
      end
      
      it 'should stringify :page_drafted' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :page_drafted)
        
        strf.should == '%s -> %s вернул на редактирование мобильную страницу "%s"'
        vars.should have(3).items
      end
      
      it 'should stringify :page_unpublished' do
        strf, vars = dashboard_tail_stringify_for(@mobile_campaign, :page_unpublished)
        
        strf.should == '%s -> %s снял с публикации (удалил) мобильную страницу "%s"'
        vars.should have(3).items
      end
      
    end # context 'MobileCampaign'
    
    
    # test helper methods
    def dashboard_tail_stringify_for(instanse, transition)
      instanse.update_dashboard!(transition)
      DashboardTail.last.stringify
    end
    
  end # describe Stringify
end