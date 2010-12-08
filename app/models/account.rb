class Account < ActiveRecord::Base
  
  has_many :users

  # init final state machine
  include AASM
  
  aasm_column :state
  aasm_initial_state :activated
  
  aasm_state :activated
  aasm_state :disabled
  
  aasm_event :activate do
    transitions :to => :activated, :from => [:disabled]
  end
  
  aasm_event :disable do
    transitions :to => :disabled, :from => [:activated]
  end


  AVAILABLE_TYPES = %w[business reseller]
  
  def business?
    is?(:business)
  end
  
  def reseller?
    is?(:reseller)
  end
  
  def is?(type)
    kind_of == type.to_s
  end
  
end
