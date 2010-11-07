# ---
Factory.define :local_click, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '127.0.0.1'
end

# Ukraine
Factory.define :ukr_click, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '178.94.71.150'
end

# Kiev, Ukraine
Factory.define :kiev_click, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '194.0.131.18'
end

# Moscow, Russian Federation
Factory.define :moscow_click, :class=> Click do |t|
  t.association   :short_url, :factory=> :short_url
  t.ip_address    '81.19.70.3'
end