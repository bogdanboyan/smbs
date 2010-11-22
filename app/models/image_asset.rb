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

class ImageAsset < AssetFile
  
  has_attached_file :asset,
      :styles => { :preview => "850x560>", :view => "200x200#", :thumbnail => "60x60#" },
      :url  => "/assets/mobcn/:id/:basename.:style.:extension",
      :path => ":rails_root/public/assets/mobcn/:id/:basename.:style.:extension"

  validates_attachment_presence :asset

  validates_attachment_content_type :asset, 
      :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/svg+xml', 'image/tiff']

end