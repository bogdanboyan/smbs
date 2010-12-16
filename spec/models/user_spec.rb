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
  
  describe "with require_non_blank_passwords" do
    before(:each) do
      @user = Factory.build :user
    end

    it { @user.require_non_blank_passwords.should be_nil }

    context "when it false" do
      it "should be valid when blank password assigned" do
        @user.require_non_blank_passwords = false
        @user.password = " "
        @user.password_confirmation = " "
        @user.should be_valid
      end
    end
    
    context "when it false" do
      it "should be invalid when blank password assigned" do
        @user.require_non_blank_passwords = true
        @user.password = " "
        @user.password_confirmation = " "
        @user.should_not be_valid
      
        @user.errors[:password].should == ['is too short (minimum is 4 characters)']
        @user.errors[:password_confirmation].should == ['is too short (minimum is 4 characters)']
      end
    end
  end
  
end