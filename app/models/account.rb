#encoding: utf-8
class Account < ActiveRecord::Base
  
  has_many :users

  has_many :short_urls
  has_many :mobile_campaigns
  has_many :bar_codes
  
  validates_length_of :title, :minimum => 4
  
  # init final state machine
  include AASM
  
  aasm_column :state
  aasm_initial_state :activated
  
  aasm_state :activated
  aasm_state :disabled
  
  aasm_event :activate do
    transitions :to => :activated, :from => [ :disabled ], :on_transition => Proc.new { |a| a.users.each { |u| u.activate! if u.pending? } }
  end
  
  aasm_event :disable do
    transitions :to => :disabled, :from => [ :activated ], :on_transition => Proc.new { |a| a.users.each { |u| u.disable! if u.activated? } }
  end


  AVAILABLE_TYPES = %w[business reseller]


  def is?(type)
    kind_of == type.to_s
  end
  
end
