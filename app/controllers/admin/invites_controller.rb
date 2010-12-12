class Admin::InvitesController < Admin::BaseController
  
  def index
    @invites = Invite.all
  end
  
end
