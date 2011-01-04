module MobileApp::CampaignsHelper
  
  def is_a_data?(model, type)
    model[:type] == type
  end
  
  def prepared_images(images_model)
    images_model.map! do |data|
      data = data.symbolize_keys and data[:instance] = ImageAsset.find(data[:asset_id])
      data
    end
  end
  
  def t9e(text, group = :text)
    case group
      when :header then text =~ /(h1\.|h2\.|h3\.)/ ? textilize(text) : "<h1>#{text}</h1>"
      when :text   then textilize_without_paragraph(text)
    end
  end
  
  alias :textilize_without_paragraph :textilize
  def textilize(text)
     RedCloth.new(text).to_html
  end
  
end