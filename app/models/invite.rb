class Invite < ActiveRecord::Base
  
  validates_uniqueness_of :email, :on => :create
  
  validates_length_of :company, :minimum => 3, :maximum => 25
  validates_length_of :phone, :minimum => 3, :maximum => 13
  
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
