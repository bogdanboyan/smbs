require 'spec_helper'

describe DashboardTail do
  
  context "specify fields" do
    
    it {should have_db_column(:transition)           }

    it {should belong_to(:account)                   }
    it {should belong_to(:user)                      }
    it {should belong_to(:attachable)                }
    it {should belong_to(:transition_user)           }
    
    it {should have_db_index(:account_id)            }
    it {should have_db_index(:user_id)               }
    
  end
  
  
end