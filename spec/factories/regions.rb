Factory.define :kiev_region, :class => Region do |r|
  r.code "Kiev"
  r.name "Kiev Region"
  
  r.association :country, :factory => :ukraine
end

Factory.define :vinitsa_region, :class => Region do |r|
  r.code "Vinitsa"
  r.name "Vinitsa Region"
  
  r.association :country, :factory => :ukraine
end

Factory.define :lvov_region, :class => Region do |r|
  r.code "Lvov"
  r.name "Lvov Region"
  
  r.association :country, :factory => :ukraine
end