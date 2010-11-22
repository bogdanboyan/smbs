require 'spec_helper'

describe AssetFile do
  
  it { should have_db_column(:asset_content_type) }
  it { should have_db_column(:asset_file_name)    }
  it { should have_db_column(:asset_file_size)    }
  it { should have_db_column(:type)               }
  it { should belong_to(:mobile_campaign)         }
  
end