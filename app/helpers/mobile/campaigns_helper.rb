module Mobile::CampaignsHelper
  
  def is_a_data?(model, type)
    model[:type] == type
  end
  
  def prepared_images(images_model)
    images_model.map! do |data|
      data = data.symbolize_keys and data[:instance] = ImageAsset.find(data[:asset_id])
      data
    end
  end
  
  def render_partials_to_js_object
    <<-JS_OBJECT 
    {
        text_container   : '#{render_partial_for 'text_container'}',
        header_container : '#{render_partial_for 'header_container'}',
        image_container  : '#{render_partial_for 'image_container'}'
    } 
    JS_OBJECT
  end
  
  def render_document_title(page)
    page ? page.title : "Untitled #{Time.now.to_date.to_s(:simple)}"
  end
  
  def t9e(text, group = :text)
    case group
      when :header then text =~ /(h1\.|h2\.|h3\.)/ ? textilize(text) : "<h1>#{text}</h1>"
      when :text   then textilize_without_paragraph(text)
    end
  end
  
  def compress_css(source)
    source.gsub!(/\s+/, " ")           # collapse space
    source.gsub!(/\/\*(.*?)\*\//, "")  # remove comments - caution, might want to remove this if using css hacks
    source.gsub!(/\} /, "}\n")         # add line breaks
    source.gsub!(/\n$/, "")            # remove last break
    source.gsub!(/ \{ /, " {")         # trim inside brackets
    source.gsub!(/; \}/, "}")          # trim inside brackets
    source
  end


  private
  
    def render_partial_for container
      render(:partial=> 'document_partials', :object=> container).delete("\n")
    end
  
end
