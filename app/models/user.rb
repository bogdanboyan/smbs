#encoding: utf-8
class User < ActiveRecord::Base
  
  belongs_to :account
  
  # validation
  validates_length_of     :full_name, :minimum => 4, :allow_blank => true
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  # init final state machine
  include AASM

  aasm_column :state

  aasm_initial_state :pending

  aasm_state :invited,   :after_enter => Proc.new { |user| user.reset_perishable_token! and UserMailer.account_activation_instructions(user).deliver }
  aasm_state :activated
  aasm_state :pending


  aasm_event :invite do
    transitions :to => :invited, :from => [ :pending, :invited ]
  end

  aasm_event :activate do
    transitions :to => :activated, :from => [ :invited, :pending ], :on_transition => Proc.new { |user| UserMailer.account_activate_notice(user).deliver }
  end
  
  aasm_event :disable do
    transitions :to => :pending, :from => [ :activated ], :on_transition => Proc.new { |user| UserMailer.account_disable_notice(user).deliver  }
  end


  # init authlogic
  acts_as_authentic do |c|
    c.session_class UserSession
  end
  
  
  include Dashboardable
  
  
  # Skip blank passwords ignoring
  attr_accessor :require_non_blank_passwords
  
  def generate_random_password
    random_password            = generate_password
    self.password              = random_password
    self.password_confirmation = random_password
  end


  protected
  
  def ignore_blank_passwords?
    require_non_blank_passwords != true                                            
  end
  
  # authlogic magic state
  def active?
    self.account.activated? and self.activated?
  end
  
  def generate_password
    ActiveSupport::SecureRandom.hex(3)
  end
  
end