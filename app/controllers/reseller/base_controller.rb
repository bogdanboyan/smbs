class Reseller::BaseController < ApplicationController
  layout 'dashboard'
  
  before_filter :require_reseller_user
end