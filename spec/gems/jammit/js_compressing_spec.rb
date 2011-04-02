require 'spec_helper'
require 'closure-compiler'

describe 'yui-compressor javascript compressing' do
  
  before(:all) do
    @comp       = Closure::Compiler.new
    @munge_comp = Closure::Compiler.new(:compilation_level => 'ADVANCED_OPTIMIZATIONS')
  end
  
  def specify_compression(compressor, js_content)
    compressed = compressor.compile(js_content)
    compressed.should_not be_empty
  end
  
  
  JS_DIRECTORIES = Jammit.configuration[:javascripts].each_pair do |key, value|
    Jammit.configuration[:javascripts][key] = value.map { |pattern| Dir[pattern] }.flatten.delete_if{ |file| file =~ /.jst/ }
  end
  
  JS_DIRECTORIES.each_key do |key|
    
    context "for #{key} package" do
      
      it 'should compress ALL package' do
        js_package_string = JS_DIRECTORIES[key].map {|js_file| File.open(js_file).read }.join("\n")
        
        specify_compression(@comp, js_package_string)
      end
      
      JS_DIRECTORIES[key].each do |js_file|
        
        it "should compress #{js_file} file" do
          specify_compression(@comp, File.open(js_file).read)
        end
        
        # it "should munge and compress #{js_file} file" do
        #   specify_compression(@munge_comp, File.open(js_file).read)
        # end
        
      end
      
    end # each
    
  end # context
  
end # describe