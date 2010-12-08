require 'spec_helper'

describe User do
  
  context "specify fields" do
    
    it {should have_db_column(:full_name)            }
    it {should have_db_column(:email)                }
    it {should have_db_column(:crypted_password)     }
    it {should have_db_column(:password_salt)        }
    it {should have_db_column(:persistence_token)    }
    it {should have_db_column(:single_access_token)  }
    it {should have_db_column(:perishable_token)     }
    it {should have_db_column(:login_count)          }
    it {should have_db_column(:failed_login_count)   }
    it {should have_db_column(:last_request_at)      }
    it {should have_db_column(:current_login_at)     }
    it {should have_db_column(:current_login_ip)     }
    it {should have_db_column(:last_login_ip)        }
    it {should have_db_column(:state)                }
    
    it {should belong_to(:account)                   }
    it {should have_db_index(:account_id)            }
    
  end
  
  context "with states" do
    
    before(:all) do
      @user = Factory.create :user
    end
    
    it { @user.should be_activated    }
    it { @user.should_not be_pending  }
    
    context "with disable! event" do
      specify { @user.disable!; @user.should be_pending }
    end
    
    context "with activate! event" do
      specify { @user.activate!; @user.should be_activated }
    end

  end
  
  
end