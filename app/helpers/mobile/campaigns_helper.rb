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


  private
  
  def render_partial_for container
    render(:partial=> 'partials', :object=> container).delete("\n")
  end
  
end
