#encoding: utf-8
class User < ActiveRecord::Base
  
  belongs_to :account
  
  # init final state machine
  include AASM

  aasm_column :state

  aasm_initial_state :activated

  aasm_state :activated
  aasm_state :pending

  aasm_event :activate do
    transitions :to => :activated, :from => [:pending]
  end
  
  aasm_event :disable do
    transitions :to => :pending, :from => [:activated]
  end
  
  # init authlogic
  acts_as_authentic do |c|
    c.session_class UserSession
  end
  
end
