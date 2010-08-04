module ShortenersHelper
  
  def short_url_title(model)
    "ссылка на: %s  [ %s ]" % [model.origin, model.short]
  end
  
end