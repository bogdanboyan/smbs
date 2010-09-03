class Mobile < ActiveRecord::Base

  validates_uniqueness_of :model, :scope => :manufacturer

end
