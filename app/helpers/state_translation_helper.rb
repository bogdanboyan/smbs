#encoding: utf-8

module StateTranslationHelper
  
  def t_campaign_state(instance)
    title = case instance.current_state
      when 'draft' then 'черновик'
    end
    
    '%s: ' % title if title
  end
  
  def t_short_url_state(instance)
    title = case instance.current_state
      when 'pending' then 'заблокирован'
    end
    
    '%s: ' % title if title
  end
  
end