require 'spec_helper'

describe BarCode do
  
  context "specify fields" do
    
    it {should have_db_column(:type)             }
    it {should have_db_column(:origin)           }
    it {should have_db_column(:tel)              }
    it {should have_db_column(:text)             }
    it {should have_db_column(:source)           }
    it {should have_db_column(:version)          }
    it {should have_db_column(:level)            }

    it {should belong_to(:account)               }
    it {should have_db_index(:account_id)        }

    it {should belong_to(:user)                  }
    it {should have_db_index(:user_id)           }
    
  end
  
  it 'should save qr code image bundle' do
    qr = TextCode.create!(:text => 'hello world')
    file_path = BarbyBarcode.image_path(:id => qr.id)
    
    file_path.should == "assets/barcodes/#{qr.id}/#{qr.id}.thumbnail.png"
    %w(preview thumbnail).each { |style| File.exist?("public/assets/barcodes/#{qr.id}/#{qr.id}." + style + ".png").should be_true }
  end
  
  describe "dashboardable" do
    
    before(:all) { @qr_code = BarCode.new }
    
    it { @qr_code.should be_kind_of(Dashboardable) }
    
    specify "update_dashboard with invalid transition" do
      -> { @qr_code.assert_transition_key(:yo!) }.should raise_error(RuntimeError)
    end
    
    specify "update_dashboard with valid transition" do
      -> { @qr_code.assert_transition_key(:qr_code_created)      }.should_not raise_error
    end
    
  end
  
end

describe SmsCode do
  
  it 'should be valid' do
    SmsCode.new(:tel=>'').valid?.should be_false
    SmsCode.new(:tel=>'+380978053300').valid?.should be_true
    SmsCode.new(:tel=>'text').valid?.should be_false
    
    SmsCode.new(:tel=>'+380978053300', :text=>'ref#').encode_string.should eql("SMSTO:+380978053300:ref#")
    SmsCode.new(:tel=>'+380978053300').encode_string.should eql("SMSTO:+380978053300")
  end
end

describe LinkCode do
  
  it 'should be valid' do
    LinkCode.new(:origin=>'').valid?.should be_false
    LinkCode.new(:origin=>'yandex.ru').valid?.should be_true
    
    lc = LinkCode.new(:origin=>'ya.ru')
    lc.valid?
    lc.encode_string.should eql('http://ya.ru')
  end
end

describe TextCode do
  
  it 'should be valid' do
    TextCode.new(:text=>'simple text').encode_string.should eql('simple text')
  end
end
