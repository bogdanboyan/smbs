class ImageAsset < AssetFile
  
  has_attached_file :asset,
      :styles => { :preview => "850x560>", :view => "200x200#", :thumbnail => "60x60#" },
      :url  => "/assets/mobcn/:id/:basename.:style.:extension",
      :path => ":rails_root/public/assets/mobcn/:id/:basename.:style.:extension"

  validates_attachment_presence :asset

  validates_attachment_content_type :asset, 
      :content_type => ['image/gif', 'image/jpeg', 'image/png', 'image/svg+xml', 'image/tiff']

end