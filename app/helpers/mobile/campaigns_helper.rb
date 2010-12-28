# encoding: utf-8
require 'redcloth'

module Mobile::CampaignsHelper
  
  def render_partials_to_js_object
    <<-JS_OBJECT 
    {
        text_container   : '#{render_partial_for('text_container')}',
        header_container : '#{render_partial_for('header_container')}',
        image_container  : '#{render_partial_for('image_container')}'
    } 
    JS_OBJECT
  end
  
  def render_document_title(page)
    page ? page.title : "Без названия #{Time.now.to_date.to_s(:simple)}"
  end
  
  def clicks_counter_link_to(short_url)
    (short_url && short_url.clicks_count > 0) ? link_to(short_url.clicks_count, statistic_path(short_url)) : 0
  end
  
  def switch_campaign_state_button(instance)
    case instance.current_state
      when 'draft'
        confirm = 'Содержание каждой страницы проверяется админинистрацией. После подтверждения страница будет опубликова. Вы уверены что готовы опубликовать?'
        button_to 'Опубликовать страницу', approve_mobile_campaign_path(@campaign), :method => :put, :confirm => confirm
      when 'published' then 'страница опубликована'
      when 'pending'   then 'проверяется содержание страницы'
    end
  end
  
  private
  
  def render_partial_for container
    render(:partial=> 'partials', :object=> container).delete("\n")
  end
  
end
