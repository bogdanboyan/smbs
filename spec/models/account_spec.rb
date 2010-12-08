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
    
    before(:all) do
      @account = Account.new
    end
    
    it { @account.should be_activated    }
    it { @account.should_not be_disabled }
    
    context "with disable! event" do
      specify { @account.disable!; @account.should be_disabled }
    end
    
    context "with activate! event" do
      specify { @account.activate!; @account.should be_activated }
    end

  end

end