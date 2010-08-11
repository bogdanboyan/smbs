require File.dirname(__FILE__) + '/../spec_helper'

describe DataSource do

  [
    ['shortener' , DataSource::Shortener ],
  ].each do |param, klass|

    it "should return #{klass.name} instance for #{param} param" do
      DataSource.service(param).should be_instance_of(klass)
    end

  end
  
  # it 'Q: how test this?' do
  #   DataSource::Shortener.should_receive(:clicks).with(10)
  #   DataSource.fetch('shortener', 'clicks', 10)
  # end

end
