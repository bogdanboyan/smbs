#encoding: utf-8
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
    
    it { @user.should be_pending          }
    it { @user.should_not be_invited      }
    it { @user.should_not be_activated    }
    
    context "with invite! event" do
      specify { @user.invite!; @user.should be_invited; ActionMailer::Base.deliveries.should have(1).item }
    end
    
    context "with activate! event" do
      specify { @user.activate!; @user.should be_activated; ActionMailer::Base.deliveries.should have(2).item }
    end
    
    context "with disable! event" do
      specify { @user.disable!; @user.should be_pending; ActionMailer::Base.deliveries.should have(3).item }
    end
    
  end
  
  describe "with require_non_blank_passwords" do
    before(:each) do
      @user = User.create :email => 'rspec@yam.co.ua', :password => 'rspec!', :password_confirmation => 'rspec!'
    end

    it { @user.require_non_blank_passwords.should be_nil }

    context "when it false" do
      it "should be valid when blank password assigned" do
        @user.require_non_blank_passwords = false
        @user.should be_valid
      end
    end
    
    context "when it false" do
      it "should be invalid when blank password assigned" do
        @user.require_non_blank_passwords = true
        @user.password = " "
        @user.password_confirmation = " "
        @user.should_not be_valid
      
        @user.errors[:password].should == ['недостаточной длины (не может быть меньше 4 символа)']
        @user.errors[:password_confirmation].should == ['недостаточной длины (не может быть меньше 4 символа)']
      end
    end
  end # end describe
  
  describe "dashboardable" do
    
    before(:all) { @user = User.new }
    
    it { @user.should be_kind_of(Dashboardable) }
    
    specify "update_dashboard with invalid transition" do
      lambda { @user.assert_transition_key(:yo!) }.should raise_error(RuntimeError)
    end
    
    specify "update_dashboard with valid transition" do
      lambda { @user.assert_transition_key(:user_created)        }.should_not raise_error
      lambda { @user.assert_transition_key(:user_updated)        }.should_not raise_error
      lambda { @user.assert_transition_key(:user_activated)      }.should_not raise_error
    end
    
  end
  
  
end