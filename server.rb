# cargamos todos las clases, modulos etc de lib, controllers y models
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/controllers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file| require file }
 
require 'webrick'
include WEBrick

s = HTTPServer.new(:Port => 3000)

class MyServlet < HTTPServlet::AbstractServlet
  
  def do_GET(request, response)
    puts ""
    puts "-------------------------------------"
    params = Router.get_params(request)
    logger(params)
    response.body = Dispatcher.dispatch(params)    
    response['Content-Type'] = "text/html"
  end
  
  alias :do_POST :do_GET
  
  def logger(params)
    string_params = "{ "
    params.each { |k,v| string_params << ":#{k} => '#{v}', " }
    string_params = string_params[0..-3]
    string_params << " } "
    puts string_params
  end
  
end

LoadModels.load_models

s.mount("/", MyServlet)

trap("INT"){
  s.shutdown
}
s.start