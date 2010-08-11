# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)

class AnalyticDataSourceApp

  # GET /ds/:shortener/:86/:clicks(:params)+
  # GET /ds/:shortener/:86/:cities(:params)+
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/ds\/shortener\/clicks/
      puts env.inspect
      
      [200, {"Content-Type" => "json"}, [
        {
          :status => 'ok', :reqId => 0, 
          :table =>
            {
              :cols => [ {:id => '1', :label => 'Период', :type => 'string'}, {:id => '2', :label => '', :type => 'number'} ],
              :rows => [ {:c => [{:v => '2004'}, {:v => 400}]}, {:c => [{:v => '2005'}, {:v => 500}]} ],
            }
        }.to_json
      ]]
    else
      [404, {"Content-Type" => "text/html"}, ["Not Found"]]
    end
  end
end
