# encoding: utf-8
module Dashboardable
  module Stringify
    
    class << self
      include ActionView::Helpers::DateHelper
    end
  
    STRFTRANSITION = {
  
      MobileCampaign => lambda do |tail|
      
        vars = [tail.transition_user.account, tail.transition_user]
      
        case tail.transition.to_sym
        when :page_created
          trnf = 'создал мобильную страницу "%s"'
          vars << tail.attachable
        
        when :content_changed
          trnf = 'внес изменения для мобильной страницы "%s"'
          vars << tail.attachable
        
        when :short_url_assigned 
          trnf = 'добавил короткий адрес %s для мобильной страницы "%s"'
          vars << tail.attachable.short_url << tail.attachable
        
        when :short_url_generated
          trnf = 'создал короткий адрес %s для мобильной страницы "%s"'
          vars << tail.attachable.short_url << tail.attachable
        
        when :page_published
          trnf = 'опубликовал мобильную страницу "%s"'
          vars << tail.attachable
        
        when :page_drafted
          trnf = 'вернул на редактирование мобильную страницу "%s"'
          vars << tail.attachable
        
        when :page_unpublished
          trnf = 'снял с публикации (удалил) мобильную страницу "%s"'
          vars << tail.attachable
        
        end
      
        ["%s -> %s #{trnf}", vars]
      end,
  
      User => lambda do |tail|
      
        vars = [tail.transition_user.account, tail.transition_user]
      
        case tail.transition.to_sym
        when :user_created
          trnf = 'добавил пользователя %s для аккаунта %s'
          vars << tail.attachable << tail.attachable.account
        
        when :user_updated
          trnf = 'изменил информацию о пользователе %s (%s)'
          vars << tail.attachable << tail.attachable.account
        
        when :user_activated
          trnf = 'активировал свой аккаунт'
          
          if current_login_at = tail.attachable.current_login_at
            trnf = trnf + ' и логинился %s назад'
            vars << time_ago_in_words(current_login_at)
          end
        end
      
        ["%s -> %s #{trnf}", vars]
      end,
    
      ShortUrl => lambda do |tail|
        
        vars = [tail.transition_user.account, tail.transition_user]
        
        case tail.transition.to_sym
        when :shortener_created
          trnf = 'создал короткий адрес %s для %s'
          vars << tail.attachable.link << tail.attachable.origin
        end
        
        ["%s -> %s #{trnf}", vars]
      end,
      
      BarCode => lambda do |tail|
        
        vars = [tail.transition_user.account, tail.transition_user]
        
        case tail.transition.to_sym
        when :qr_code_created
          trnf = 'создал QR код который содержит %s'
          vars << tail.attachable
        end
        
        ["%s -> %s #{trnf}", vars]
      end
    }
  
  
    def stringify
      STRFTRANSITION[STRFTRANSITION.keys.find { |label| attachable.kind_of?(label) }].call(self) if can_stringify?
    end
  
    def can_stringify?
      Dashboardable::TRANSITIONS[Dashboardable::TRANSITIONS.keys.find { |label| attachable.kind_of?(label) }].try(:include?, transition.to_sym) #and STRFTRANSITION[attachable.class]
    end
  end # module Stringify
end