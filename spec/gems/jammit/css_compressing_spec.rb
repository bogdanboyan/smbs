require 'spec_helper'
require "yui/compressor"

describe 'yui-compressor stylesheet compressing' do
  
  before(:all) do
    @comp       = YUI::CssCompressor.new
  end
  
  def specify_compression(compressor, css_content)
    compressed = compressor.compress(css_content)
    compressed.should_not be_empty
  end
  
  CSS_DIRECTORIES = Jammit.configuration[:stylesheets].each_pair do |key, value|
    Jammit.configuration[:stylesheets][key] = value.map { |pattern| Dir[pattern] }.flatten
  end
  
  CSS_DIRECTORIES.each_key do |key|
    
    context "for #{key} package" do
      
      it 'should munge and compress ALL package' do
        css_package_string = CSS_DIRECTORIES[key].map {|css_file| File.open(css_file).read }.join("\n")
        
        specify_compression(@comp, css_package_string)
      end
      
      CSS_DIRECTORIES[key].each do |css_file|
        
        it "should compress #{css_file} file" do
          specify_compression(@comp, File.open(css_file).read)
        end
        
      end
      
    end # each
    
  end # context
  
end
