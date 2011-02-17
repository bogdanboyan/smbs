module DashboardHelper
  
  def clickable_dashboard_item(tail, opts = {})
    item = ClickableDashboardTail.new(tail, self)
    
    html = item.to_html(opts)
    html
  end
  
  class ClickableDashboardTail
    
    def initialize(tail, env)
      @tail, @env = tail, env
      @strf, @vars = tail.stringify
    end
    
    
    def to_html(opts)
      # invoke map_common_vars_for_admin for admin opts
      send "map_common_vars_for_%s" % opts[:for]
      # invoke map_mobile_campaign_vars_for_admin for mobile_campaign and admin opts
      send "map_%s_vars_for_%s"     % [@tail.attachable.class.model_name.underscore, opts[:for]]
      
      @strf % @vars
    end
    
    
    protected
    
    def map_mobile_campaign_vars_for_admin
      mobile_campaign_index = 2
      
      if @tail.transition == 'short_url_assigned' || @tail.transition == 'short_url_generated'
        short_url = @vars[2] and @vars[2] = short_url.link
        mobile_campaign_index = 3
      end
      
      mobile_campaign = @vars[mobile_campaign_index]
      @vars[mobile_campaign_index] = "<a href='#{mobile_app_campaign_path(mobile_campaign)}'>#{mobile_campaign.title}</a>"
    end
    
    def map_user_vars_for_admin
      if not @tail.transition == 'user_activated'
        account = @vars[3] and @vars[3] = "<a href='#{settings_admin_account_path(account)}'>#{account.title}</a>"
        user = @vars[2]    and @vars[2] = user.title # "<a href='#{edit_admin_account_user_path(account, user)}'>#{user.title}</a>"
      end
    end
    
    def map_short_url_vars_for_admin
      # nothing map
    end
    
    
    private
    
    def map_common_vars_for_admin
      account = @vars[0]
      @vars[0] = "<a href='#{settings_admin_account_path(account)}'>#{account.title}</a>"
      
      user = @vars[1] and @vars[1] = user.title
    end
    
    # proxy pass to rails helper environment, for example for link_to or dynamic routes methods
    def method_missing(method, *args)
      @env.send(method, args)
    end
    
  end
end