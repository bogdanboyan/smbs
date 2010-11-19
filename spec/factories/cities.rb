# encoding: utf-8 
Factory.define :kiev, :class => City do |c|
  c.name       'Kiev'
  c.association :country, :factory => :ukraine
  c.association :region,  :factory => :kiev_region
end


Factory.define :borispol, :class => City do |c|
  c.name        'Borispol'
  
  c.association :country, :factory => :ukraine
  c.association :region,  :factory => :kiev_region
end


Factory.define :vinitsa, :class => City do |c|
  c.name       'Vinitsa'
  
  c.association :country, :factory => :ukraine
  c.association :region,  :factory => :vinitsa_region
end