# encoding: utf-8
require 'data_source'

module Rackup
  class AnalyticDataSourceApp < ActionController::Metal

    def fetch
      response = begin
        prepare_response(DataSource.fetch(params[:source], params[:member], params[:id]))
        
        set_headers :content_type => 'json', :response_body => response.to_json
      rescue
        Rails.logger.warn("Can't :fetch analytic data for #{params} request")
        
        set_headers :status => 404, :response_body => 'Запрашиваем ресурс не найден'
      end
    end


    private

    def prepare_response(data)
      { :status => 'ok', :reqId => params[:tqx].split(':').last,:table => data }
    end
    
    def set_headers(options)
      options.each { |k,v| self.send k.to_s+'=', v }
    end
    
  end
end