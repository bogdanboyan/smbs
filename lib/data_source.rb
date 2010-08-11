module DataSource

  autoload :Shortener,  'data_source/shortener'

  def self.service(name)
    const_get(name.to_s.classify).new
  end
  
  #DataSource.fetch('shortener', 'clicks', 10) > DataSource::Shortener.clicks(id, params)
  def self.fetch(data, action, *opts)
    const_get(data.to_s.classify).new.send(action, *opts)
  end

end