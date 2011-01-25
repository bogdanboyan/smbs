class DataSource

  autoload :Shortener,  'data_source/shortener'

  class << self

    def service(name)
      const_get(name.to_s.classify).new
    end
  
    #DataSource.fetch('shortener', 'clicks', 10) > DataSource::Shortener.clicks(id, params)
    def fetch(data, action, *opts)
      const_get(data.to_s.classify).new.send(action, *opts)
    end
    
  end

end