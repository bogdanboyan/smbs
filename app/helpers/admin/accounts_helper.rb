#encoding: utf-8
module Admin::AccountsHelper
  
  def account_pages_title
    "Аккаунт %s" % @account.title
  end
  
  def humanize_state(state)
    case state
      when 'activated' then 'активирован'
      when 'pending'   then 'заблокирован'
    end
  end
  
  def humanize_state_action(state)
    case state
      when 'disable'  then 'заблокировать'
      when 'activate' then 'активировать'
    end
  end
  
  def switch_state_action_button(options)
    action = case options[:current_state]
      when 'activated' then 'disable'
      when 'pending'   then 'activate'
    end
    
    name = humanize_state_action(action)
    
    button_to name.camelize, "#{options[:path]}/#{action}", :confirm => "Вы уверны что хотите #{name} пользователя?", :method => :put
  end
  
end
