require './app/models/usuarios'

class UsuariosController
  
  def index(params)
    u = Usuarios.all
    
    return binding
  end
  
  def new(params)
    u = Usuarios.find(1)

    return binding
  end
  
  def show(params)
    usuario = Usuarios.find(params[:id].to_i)
    
    return binding
  end
  
end