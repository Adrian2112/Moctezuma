require './app/models/usuarios'

class UsuariosController
  
  def index(params)

    return binding
  end
  
  def new(params)
    u = Usuarios.find(1)
    
    return binding
  end
  
  def show(params)
    usuario = params[:id]
    
    return binding
  end
  
end