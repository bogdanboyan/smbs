Factory.define :click_one, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '127.0.0.1'
end

Factory.define :click_two, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '77.88.216.22'
end