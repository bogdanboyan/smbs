require 'spec_helper'

describe Click do
  
  context "specify fields" do
    
    it {should have_db_column(:ip_address)  }
    it {should have_db_column(:referer)     }
    it {should have_db_column(:located)     }
    it {should have_db_column(:latitude)    }
    it {should have_db_column(:longitude)   }
                                            
    it {should belong_to(:short_url)        }
    it {should belong_to(:user_agent)       }
    it {should belong_to(:country)          }
    it {should belong_to(:region)           }
    it {should belong_to(:city)             }

    it {should have_db_index(:short_url_id)                }
    it {should have_db_index(:user_agent_id)               }
    it {should have_db_index([:short_url_id, :created_at]) }
    
  end
  
end