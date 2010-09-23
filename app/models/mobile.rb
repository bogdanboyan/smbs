# == Schema Info
#
# Table name: mobiles
#
#  id           :integer(4)      not null, primary key
#  height       :integer(4)      default(0)
#  manufacturer :string(255)
#  model        :string(255)
#  resolution   :string(255)
#  width        :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime

class Mobile < ActiveRecord::Base

  validates_uniqueness_of :model, :scope => :manufacturer

end
