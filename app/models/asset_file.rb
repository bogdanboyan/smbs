# == Schema Info
#
# Table name: asset_files
#
#  id                 :integer(4)      not null, primary key
#  page_id            :integer(4)
#  asset_content_type :string(255)
#  asset_file_name    :string(255)
#  asset_file_size    :integer(4)
#  type               :string(255)
#  created_at         :datetime
#  updated_at         :datetime

class AssetFile < ActiveRecord::Base
end
