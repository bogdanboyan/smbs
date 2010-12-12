class Reseller::BaseController < ApplicationController
  
  abstract!
  
  layout 'dashboard'
  
  before_filter :require_reseller_user
end