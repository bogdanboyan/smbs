module Rackup
  class MobileCampaignsApp < ActionController::Metal
    
    include ActionController::Rendering
    
    append_view_path "#{Rails.root}/app/views"
    
    
    def show
      @mbc = MobileCampaign.find(params[:id])
      @document_model = @mbc.document_model_as(:array).map! {|entity| entity.symbolize_keys }
      
      render
    end
    
    
    #
    # Helper methods
    #
    def compress_css(source)
      source.gsub!(/\s+/, " ")
      source.gsub!(/\/\*(.*?)\*\//, "")
      source.gsub!(/\} /, "}\n")
      source.gsub!(/\n$/, "")
      source.gsub!(/ \{ /, " {")
      source.gsub!(/; \}/, "}")
      source
    end
    
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
end