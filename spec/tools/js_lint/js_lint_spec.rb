require 'spec_helper'

describe 'specify project JS with JavaScriptLint tool' do
  JS_DIRECTORIES.each_pair do |namespace, js_files|
    # check only project js (skip vendor js)
    js_files.delete_if { |js_file| js_file.include?('/vendor/') }.each do |js_file|
      it "should check '#{js_file}' from '#{namespace}' namespace" do
        system("jsl -nofilelisting -nologo -conf spec/tools//js_lint/js_lint.conf -process #{File.new(js_file).path}").should be_true
      end # it
    end # each
  end # each_pair
end # describe