Factory.define :image_asset do |t|
  t.id                 100
  t.asset_content_type 'image/png'
  t.asset_file_name    'thumbnail'
  t.asset_file_size    1024
end