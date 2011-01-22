class AddNewMobileDevices < ActiveRecord::Migration
  def self.up

    Mobile.create! :manufacturer=>'Nokia', :model=>'5228', :resolution=>'360 x 640'
    Mobile.create! :manufacturer=>'Nokia', :model=>'C6', :resolution=>'360 x 640'
    Mobile.create! :manufacturer=>'Nokia', :model=>'C7', :resolution=>'360 x 640'
    Mobile.create! :manufacturer=>'Nokia', :model=>'X3-02', :resolution=>'240 x 320'
    Mobile.create! :manufacturer=>'Nokia', :model=>'X2', :resolution=>'320 x 240'

    Mobile.create! :manufacturer=>'Sony Ericsson', :model=>'XPERIA U10', :resolution=>'480 x 854'

  end

  def self.down
  end
end
