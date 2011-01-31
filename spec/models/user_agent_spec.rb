require 'spec_helper'

describe UserAgent do
  
  context "specify fields" do
    it { should have_db_column(:details)            }
    it { should have_db_column(:profile)            }
    it { should have_db_column(:x_wap_profile)      }
    
    it { should belong_to(:mobile)                  }
    
    it { should have_db_index(:mobile_id)           }
  end
  
end