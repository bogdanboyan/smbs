require 'spec_helper'

describe Account do
  
  context "specify fields" do
    
    it {should have_db_column(:title)              }
    it {should have_db_column(:contact_phone)      }
    it {should have_db_column(:contact_person)     }
    it {should have_db_column(:address)            }
    it {should have_db_column(:city)               }
    it {should have_db_column(:bank_account)       }
    it {should have_db_column(:state)              }
    it {should have_db_column(:kind_of)            }
    
    it {should have_many(:users)                   }
    it {should have_many(:short_urls)              }
    it {should have_many(:mobile_campaigns)        }
    it {should have_many(:bar_codes)               }
    
  end
  
  context "with states" do
    
    before(:all) { @account = Account.new(:title => 'RSpec') }
    
    it { @account.should be_activated    }
    it { @account.should_not be_disabled }
    
    context "with disable! event" do
      specify { @account.disable!; @account.should be_disabled }
    end
    
    context "with activate! event" do
      specify { @account.activate!; @account.should be_activated }
    end

  end
  
  describe "dashboardable" do
    
    before(:all) { @account = Account.new }
    
    it { @account.should be_kind_of(Dashboardable) }
    
    specify "update_dashboard with invalid transition" do
      lambda { @account.assert_transition_key(:yo!) }.should raise_error(RuntimeError)
    end
    
    specify "update_dashboard with valid transition" do
      lambda { @account.assert_transition_key(:user_added)          }.should_not raise_error
      lambda { @account.assert_transition_key(:user_removed)        }.should_not raise_error
    end
    
  end
  

end