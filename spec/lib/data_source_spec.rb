# encoding: utf-8
require 'spec_helper'
require 'data_source'

describe DataSource do

  {
    'shortener' => DataSource::Shortener,
  }.each do |key, value|

    it "should return #{value.name} instance for '#{key}' key" do
      DataSource.service(key).should be_instance_of(value)
    end
  end
  
  describe DataSource::Shortener do
    
    before(:each) do
      @short_url        = Factory.create :short_url
      
      @kiev             = Factory.create :kiev, {:display => 'Киев'}
      @kiev_region      = Factory.create :kiev_region
      @vinitsa          = Factory.create :vinitsa
      @vinitsa_region   = Factory.create :vinitsa_region
      @ukraine          = Factory.create :ukraine
    end
    
    context "with 'clicks' report" do
      
      def specify_clicks_cols_structure(report)
        report.should have(2).items
        
        report[:cols].should be_instance_of(Array)
        report[:cols][0][:label].should   == "Дата"
        report[:cols][0][:type].should    == "string"
        report[:cols][1][:label].should   == "Посещений"
        report[:cols][1][:type].should    == "number"
      end
      
      def specify_clicks_rows_structure(report)
        report.should have(2).items
        
        report[:rows].should be_instance_of(Array)
        report[:rows][0].should be_instance_of(Hash)
        report[:rows][0][:c].should be_instance_of(Array)
        report[:rows][0][:c].should have(2).items
        report[:rows][0][:c][0].should be_instance_of(Hash)
        report[:rows][0][:c][0].has_key?(:v).should be_true
        report[:rows][0][:c][1].has_key?(:v).should be_true
      end
      
      it 'should return report for three days' do
        
        [ # clicks from kiev
          {:clicks => 50,  :percent => "10.0", :date => 3.days.ago.to_date },
          {:clicks => 450, :percent => "90.0", :date => 2.days.ago.to_date },
          {:clicks => 350, :percent => "50.0", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:city => @kiev, :region => @kiev_region, :country => @ukraine, :short_url => @short_url)
        end
        
        [ # clicks from vinitsa
          {:clicks => 450,  :percent => "90.0", :date => 3.days.ago.to_date },
          {:clicks => 50,   :percent => "10.0", :date => 2.days.ago.to_date },
          {:clicks => 350,  :percent => "50.0", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:city => @vinitsa, :region => @vinitsa_region, :country => @ukraine, :short_url => @short_url)
        end
        
        report = DataSource.fetch('shortener', 'clicks', @short_url.id)
        
        specify_clicks_cols_structure(report)
        specify_clicks_rows_structure(report)
        
        #puts report.to_s
        
        report[:rows].should have(3).items
        
        # report for 3.day.ago
        three_days_ago = report[:rows][0][:c]
        three_days_ago.first[:v].should == I18n.l(3.days.ago.to_date, :format => :long)
        three_days_ago.last[:v].should  == 500
        
        # report for 2.day.ago
        two_days_ago = report[:rows][1][:c]
        two_days_ago.first[:v].should   == I18n.l(2.days.ago.to_date, :format => :long)
        two_days_ago.last[:v].should    == 500
        
        # report for 1.day.ago
        one_days_ago = report[:rows][2][:c]
        one_days_ago.first[:v].should   == I18n.l(1.days.ago.to_date, :format => :long)
        one_days_ago.last[:v].should    == 700
      end
      
      it 'should return report for previous date and today' do
        [ # clicks from kiev
          {:clicks => 50,  :percent => "10.0", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:city => @kiev, :region => @kiev_region, :country => @ukraine, :short_url => @short_url)
        end
        
        user_agent = Factory.create :nokia_e51_user_agent
        11.times { Click.create(:short_url => @short_url, :ip_address => '127.0.0.1', :user_agent => user_agent) }
        
        report = DataSource.fetch('shortener', 'clicks', @short_url.id)
        
        specify_clicks_cols_structure(report)
        specify_clicks_rows_structure(report)
        
        #puts report.to_s
        
        report[:rows].should have(2).items
        
        # report for 1.day.ago
        one_days_ago = report[:rows][0][:c]
        one_days_ago.first[:v].should   == I18n.l(1.days.ago.to_date, :format => :long)
        one_days_ago.last[:v].should    == 50
        
        # report for 1.day.ago
        today = report[:rows][1][:c]
        today.first[:v].should   == I18n.l(Date.today, :format => :long)
        today.last[:v].should    == 11
      end
      
      it 'should return empty report data' do
        report = DataSource.fetch('shortener', 'clicks', -10)
        
        specify_clicks_cols_structure(report)

        report[:cols].should have(2).items
        report[:rows].should have(0).items
      end
    end
    
    context "with 'regions' report" do
      
      def specify_regions_cols_structure(report)
        report.should have(2).items
        
        report[:cols].should be_instance_of(Array)
        report[:cols][0][:label].should   == "Город"
        report[:cols][0][:type].should    == "string"
        report[:cols][1][:label].should   == "Посещений"
        report[:cols][1][:type].should    == "number"
      end
      
      def specify_regions_rows_structure(report)
        report.should have(2).items
        
        report[:rows].should be_instance_of(Array)
        report[:rows][0].should be_instance_of(Hash)
        report[:rows][0][:c].should be_instance_of(Array)
        report[:rows][0][:c].should have(2).items
        report[:rows][0][:c][0].should be_instance_of(Hash)
        report[:rows][0][:c][0].has_key?(:v).should be_true
        report[:rows][0][:c][1].has_key?(:v).should be_true
      end
      
      it 'should contains right graph' do
        [ # clicks from kiev
          {:clicks => 50,  :percent => "9.5",  :date => 3.days.ago.to_date },
          {:clicks => 450, :percent => "89.5", :date => 2.days.ago.to_date },
          {:clicks => 350, :percent => "49.5", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:city => @kiev, :region => @kiev_region, :country => @ukraine, :short_url => @short_url)
        end
        
        [ # clicks from vinitsa
          {:clicks => 450,  :percent => "89.5", :date => 3.days.ago.to_date },
          {:clicks => 50,   :percent => "9.5",  :date => 2.days.ago.to_date },
          {:clicks => 350,  :percent => "49.5", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:city => @vinitsa, :region => @vinitsa_region, :country => @ukraine, :short_url => @short_url)
        end
        
        [ # clicks from unknown target
          {:clicks => 5,  :percent => "1.0", :date => 3.days.ago.to_date },
          {:clicks => 5,  :percent => "1.0", :date => 2.days.ago.to_date },
          {:clicks => 7,  :percent => "1.0", :date => 1.days.ago.to_date },
        ].each do |params|
          SummarizedClick.create params.merge(:short_url => @short_url)
        end
        
        report = DataSource.fetch('shortener', 'regions', @short_url.id)

        specify_regions_cols_structure(report)
        specify_regions_rows_structure(report)
        
        #puts report.to_s
        
        report[:rows].should have(3).items
        
        # report for kiev city
        kiev_rows    = report[:rows][0][:c]
        kiev_rows.first[:v].should == 'Киев' # with translated display field
        kiev_rows.last[:v].should  == 850
        
        # report for vinitsa city
        vinitsa_rows = report[:rows][1][:c]
        vinitsa_rows.first[:v].should == 'Vinitsa'
        vinitsa_rows.last[:v].should  == 850
        
        # report for other cities
        other_rows   = report[:rows][2][:c]
        other_rows.first[:v].should == '*Украина'
        other_rows.last[:v].should  == 17
      end
      
      specify 'should return empty graph' do
        report = DataSource.fetch('shortener', 'regions', -10)
        
        specify_regions_cols_structure(report)

        report[:cols].should have(2).items
        report[:rows].should have(0).items
      end
    end
    
  end
end
