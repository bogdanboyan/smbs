#encoding: utf-8
module Admin::AccountsHelper
  
  def account_pages_title
    "Аккаунт %s" % @account.title
  end
  
  def humanize_state(state)
    case state
      when 'invited'   then 'ожидается активация аккаунта'
      when 'activated' then 'активирован'
      when 'pending'   then 'заблокирован'
      when 'disabled'  then 'заблокирован'
    end
  end
  
  def humanize_state_action(state)
    case state
      when 'invite'   then 'выслать повторное пригласительное'
      when 'disable'  then 'заблокировать'
      when 'activate' then 'активировать'
    end
  end
  
  def switch_state_action_button(options)
    action = case options[:current_state]
      when 'invited'   then 'invite'
      when 'activated' then 'disable'
      when 'pending'   then 'activate'
      when 'disabled'  then 'activate'
    end
    
    name = humanize_state_action(action)
    
    button_to name.camelize, "#{options[:path]}/#{action}", :confirm => "Вы уверны что хотите #{name} пользователя?", :method => :put
  end
  
end
