# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class AnalyticDataSourceApp

  # GET /ds/:shortener/:86/:clicks(:params)+
  PATH_INFO_ROUTE = /^\/ds\/(\w+)\/(\d+)\/(\w+)/

  def self.call(env)
    if env["PATH_INFO"] =~ PATH_INFO_ROUTE
      
      data, id, action = env["PATH_INFO"].scan(PATH_INFO_ROUTE).first
      
      # very slowly!!!
      data_table = DataSource.fetch(data, action, id)
      
      [200, {"Content-Type" => "json"}, [data_table.to_json] ]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
