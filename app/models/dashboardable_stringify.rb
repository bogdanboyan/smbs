# encoding: utf-8
module Dashboardable
  module Stringify
  
  STRFTRANSITION = {
  
    MobileCampaign => lambda do |tail|
      
      vars = [tail.transition_user.account, tail.transition_user]
      
      case tail.transition.to_sym
      when :page_created
        trnf = 'создал мобильную страаницу "%s"'
        vars << tail.attachable
        
      when :content_changed
        trnf = 'внес изменения для мобильной страаницы "%s"'
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
      puts "class name: " + tail.class.name
    end,
    
    ShortUrl => lambda do |tail|
      puts "class name: " + tail.class.name
    end
  }
  
  
  def stringify
    STRFTRANSITION[attachable.class].call(self) if can_stringify?
  end
  
  def can_stringify?
    Dashboardable::TRANSITIONS[attachable.class].try(:include?, transition.to_sym) and STRFTRANSITION[attachable.class]
  end
end # module Stringify
end