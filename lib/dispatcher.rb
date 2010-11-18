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

    # crea una nueva instancia de la clase del controllador
    controller_class = Kernel.const_get(controller.capitalize+"Controller").new(params)
    
    response << controller_class.render
    
    controller_class = nil
    return response
    
  end

end