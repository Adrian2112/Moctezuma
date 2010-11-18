require 'erb'

module Dispatcher

  # El dispatcher se encarga de recibir los parametros generados por
  # el router.
  # 
  # El archivo que se va a desplegar es obtenido de la carpeta
  # /app/views/:controller/:action.html.erb
  # 
  # Despues se crea una instancia del controlador, se llama a la accion
  # y se regresa el archivo previanmente leido en un string
  # 

  def Dispatcher.dispatch(params)
    response = ""
    controller = params[:controller]
    action = params[:action]

    begin
      vista = File.new("./app/views/#{controller}/#{action}.html.erb").read

      # carga el controlador que es necesario
      require "./app/controllers/#{controller}_controller"

      # crea una nueva instancia de la clase del controllador
      controller_class = Kernel.const_get(controller.capitalize+"Controller").new

      bind = controller_class.send(action, params)    
      erb = ERB.new(vista)

      response << erb.result(bind)

      controller_class = nil
      return response

    rescue Errno::ENOENT
      vista = File.new("./404.html").read
      response << vista
      return response
    end    
  end

end