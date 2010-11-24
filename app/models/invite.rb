class Invite < ActiveRecord::Base
  
  validates_uniqueness_of :email, :on => :create
  
  validates_length_of :company, :minimum => 4, :maximum => 25
  validates_length_of :phone, :minimum => 7, :maximum => 13
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_format_of :phone, :with => /[+0-9]+/, :on => :create
end
