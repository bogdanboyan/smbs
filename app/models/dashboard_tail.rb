require 'dashboardable_stringify'

class DashboardTail < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :user
  belongs_to :attachable, :polymorphic => true
  belongs_to :transition_user, :class_name => 'User'
  
  include Dashboardable::Stringify
  
end
