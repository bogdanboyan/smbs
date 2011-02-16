require 'spec_helper'

describe ShortUrl do
  
  it 'should be valid' do
    ShortUrl.new(:origin=>'ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'http://ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'https://ya.ru').valid?.should be_true
    ShortUrl.new(:origin=>'ftp://ya.ru/file').valid?.should be_true
    ShortUrl.new(:origin=>'http://').valid?.should be_false
    ShortUrl.new(:origin=>'httppss://').valid?.should be_false
    ShortUrl.new(:origin=>'http://httppss://').valid?.should be_false
    
    url = ShortUrl.new(:origin=>'ya.ru')
    url.valid?.should be_true
    url.origin.eql? 'http://ya.ru'
  end
  
  context "specify fields" do
    
    it {should have_db_column(:origin)          }
    it {should have_db_column(:short)           }
    it {should have_db_column(:clicks_count)    }
    it {should have_db_column(:title)           }
    it {should have_db_column(:description)     }
    it {should have_db_column(:current_state)   }
    
    it {should have_one(:mobile_campaign)       }
    it {should have_many(:clicks)               }
    
    it {should have_db_index(:current_state)    }
    
    it {should belong_to(:account)              }
    it {should have_db_index(:account_id)       }
    
    it {should belong_to(:user)                 }
    it {should have_db_index(:user_id)          }
  end
  
  describe "with AASM" do
    context "by default" do
      
      before(:all) do
        ShortUrl.destroy_all
        @short_url = Factory.create(:short_url)
      end
      
      it { @short_url.should be_proxied     }
      it { @short_url.should_not be_pending }
      
      context "with disable! event" do
        specify { @short_url.disable!; @short_url.should be_pending }
      end
      
      context "with enable! event" do
        specify { @short_url.enable!; @short_url.should be_proxied  }
      end
      
    end #end context "by default"
  end # end describe 'with AASM'
  
  describe "dashboardable" do
    
    before(:all) { @short_url = ShortUrl.new }
    
    it { @short_url.should be_kind_of(Dashboardable) }
    
    specify "update_dashboard with invalid transition" do
      -> { @short_url.assert_transition_key(:yo!) }.should raise_error(RuntimeError)
    end
    
    specify "update_dashboard with valid transition" do
      -> { @short_url.assert_transition_key(:shortener_created)        }.should_not raise_error
    end
    
  end # end describe 'dashboardable'
  
end