class Admin::BaseController < ApplicationController
  layout 'dashboard'
  
  before_filter :require_yamco_user
end