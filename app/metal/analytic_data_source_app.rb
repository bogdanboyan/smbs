# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'rack/request'

class AnalyticDataSourceApp

  # GET /ds/:shortener/:86/:clicks(:params)+
  PATH_INFO_ROUTE = /^\/ds\/(\w+)\/(\d+)\/(\w+)/

  def self.call(env)
    if env["PATH_INFO"] =~ PATH_INFO_ROUTE
      request = Rack::Request.new(env)
      data, id, action = request.path_info.scan(PATH_INFO_ROUTE).first
      
      # very slowly!!!
      response = prepare_response(request, DataSource.fetch(data, action, id))
      
      [200, {"Content-Type" => "json"}, [response.to_json] ]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end


  private
  
    def self.prepare_response(request, data)
      { :status => 'ok', :reqId => request.params['tqx'].split(':').last,:table => data }
    end
end