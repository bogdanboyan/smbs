require 'spec_helper'

describe DashboardTail do
  
  context "specify fields" do
    
    it {should have_db_column(:transition)           }
    # it {should have_db_column(:email)                }
    # it {should have_db_column(:crypted_password)     }
    # it {should have_db_column(:password_salt)        }
    # it {should have_db_column(:persistence_token)    }
    # it {should have_db_column(:single_access_token)  }
    # it {should have_db_column(:perishable_token)     }
    # it {should have_db_column(:login_count)          }
    # it {should have_db_column(:failed_login_count)   }
    # it {should have_db_column(:last_request_at)      }
    # it {should have_db_column(:current_login_at)     }
    # it {should have_db_column(:current_login_ip)     }
    # it {should have_db_column(:last_login_ip)        }
    # it {should have_db_column(:state)                }
    # 
    it {should belong_to(:account)                   }
    it {should belong_to(:user)                      }
    it {should belong_to(:attachable)                }
    it {should belong_to(:transition_user)           }
    
    # it {should have_db_index(:account_id)            }
    
  end
  
  
end