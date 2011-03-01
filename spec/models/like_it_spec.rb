require 'spec_helper'

describe LikeIt do

  context "specify fields" do

    it {should have_db_column(:clicks_cache)         }
    it {should have_db_column(:label)                }

    it {should belong_to(:mobile_campaign)           }
    it {should have_many(:clicks)                    }

    it {should have_db_index(:mobile_campaign_id)    }

  end
  
  
end