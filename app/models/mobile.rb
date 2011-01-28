class Mobile < ActiveRecord::Base

  has_many :user_agents

  validates_uniqueness_of :model, :scope => :manufacturer

end
