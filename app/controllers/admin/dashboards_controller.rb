class Admin::DashboardsController < ApplicationController
  
  before_filter :require_yamco_user
  
end
