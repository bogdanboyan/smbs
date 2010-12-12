class Business::BaseController < ApplicationController
  
  abstract!
  
  layout 'dashboard'
  
  before_filter :require_business_user
end