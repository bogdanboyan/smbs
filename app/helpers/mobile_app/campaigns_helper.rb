module MobileApp::CampaignsHelper
  
  def is_a_data?(entity, type)
    entity[:type] == type
  end
  
  def prepared_images(images_model)
    images_model.map! do |data|
      data = data.symbolize_keys and data[:instance] = ImageAsset.find(data[:asset_id])
      data
    end
  end
  
  def t9e(text, group = :text)
    # sanitize "<div class='item'>html block</div>", :tags => []
    # => "html block"
    sanitized_text = sanitize(text, :tags => [])
    case group
      when :header then sanitized_text =~ /(h1\.|h2\.|h3\.)/ ? textilize(sanitized_text) : "<h1>#{sanitized_text}</h1>"
      when :text   then textilize_without_paragraph(sanitized_text)
    end
  end
  
  alias :textilize_without_paragraph :textilize
  def textilize(text)
     RedCloth.new(text).to_html
  end
  
end