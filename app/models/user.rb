#encoding: utf-8
class User < ActiveRecord::Base
  
  belongs_to :account
  
  # validation
  validates_length_of     :full_name, :minimum => 4, :allow_blank => true
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # validates_uniqueness_of :email
  
  # init final state machine
  include AASM

  aasm_column :state

  aasm_initial_state :activated

  aasm_state :activated
  aasm_state :pending

  aasm_event :activate do
    transitions :to => :activated, :from => [ :pending ], :on_transition => Proc.new { |u| UserMailer.account_activate_notice(u) }
  end
  
  aasm_event :disable do
    transitions :to => :pending, :from => [ :activated ], :on_transition => Proc.new { |u| UserMailer.account_disable_notice(u)  }
  end
  
  # init authlogic
  acts_as_authentic do |c|
    c.session_class UserSession
  end
  
  # authlogic magic state
  alias :active? :activated?
end
