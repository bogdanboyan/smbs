class Admin::BaseController < ApplicationController
  
  abstract!
  
  layout 'dashboard'
  
  before_filter :require_yamco_user
end