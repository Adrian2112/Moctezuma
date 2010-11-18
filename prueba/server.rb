$LOAD_PATH << './lib'

require 'webrick'
include WEBrick
require 'erb'
require 'router'
require 'dispatcher'

s = HTTPServer.new(:Port => 3000)

class MyServlet < HTTPServlet::AbstractServlet
  def do_GET(request, response)
    
    params = Router.get_params(request)
    response.body = Dispatcher.dispatch(params)
    
    response['Content-Type'] = "text/html"
  end
    
  def do_POST(request, response)
    foo = request.query["prueba"]
    response.body = foo
    response['Content-Type'] = "text/html"
  end
  
end

s.mount("/", MyServlet)

trap("INT"){
  s.shutdown
}
s.start