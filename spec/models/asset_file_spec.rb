require 'spec_helper'

describe AssetFile do
  
  it { should have_db_column(:asset_content_type) }
  it { should have_db_column(:asset_file_name)    }
  it { should have_db_column(:asset_file_size)    }
  it { should have_db_column(:type)               }
  
  it { should have_and_belong_to_many(:mobile_campaigns) }
  
end