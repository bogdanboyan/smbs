require 'spec_helper'

describe LikeIt do

  context "specify fields" do

    it {should have_db_column(:clicks_count)         }
    it {should have_db_column(:tag)                  }

    it {should belong_to(:mobile_campaign)           }
    it {should have_many(:clicks)                    }

    it {should have_db_index(:mobile_campaign_id)    }

  end
  
  
end