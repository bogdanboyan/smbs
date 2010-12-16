class ChangeYamcoEmail < ActiveRecord::Migration
  def self.up
    user = User.find_by_email 'smbs.app@gmail.com'

    user.email     = 'support@yam.co.ua'
    user.full_name = 'Yamco Support'
    user.password  = 'yamcokickass!'
    user.password_confirmation = user.password
    
    user.save
  end

  def self.down
    User.find_by_email('support@yam.co.ua').destroy
  end
end
