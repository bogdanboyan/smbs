class CreateRootAccountAndUser < ActiveRecord::Migration
  def self.up
    account = Account.create :title => 'Yamco', :kind_of => 'yamco', :state => 'activated'
    user    = User.create :email => 'smbs.app@gmail.com', :full_name => 'SMBS app user', :password => 'smbskickass!', :password_confirmation => 'smbskickass!', :state => 'activated'
    
    account.users << user
  end

  def self.down
    Account.find_by_title('Yamco').destroy
    User.find_by_email('smbs.app@gmail.com').destroy
  end
end
