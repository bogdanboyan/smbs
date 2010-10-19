# ---
Factory.define :click_one, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '127.0.0.1'
end

# Kiev, Ukraine
Factory.define :click_two, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '77.88.216.22'
end

# Moscow, Russian Federation
Factory.define :click_three, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '93.158.134.3'
end