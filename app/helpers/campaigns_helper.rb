module CampaignsHelper
  
  def element_title(model)
    case(model)
      when BarCode  then bar_code_title(model)
      when ShortUrl then short_url_title(model)
    end
  end
  
  def underscored_type(model)
    case(model)
      when ShortUrl then model.class.name.underscore
      when BarCode  then BarCode.name.underscore
    end
  end
  
  
end
