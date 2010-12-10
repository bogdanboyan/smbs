class Business::BaseController < ApplicationController
  layout 'dashboard'
  
  before_filter :require_business_user
end