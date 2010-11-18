require './app/models/usuarios'

class UsuariosController
  
  def index(params)

    return binding
  end
  
  def new(params)
    u = Usuarios.find(1)
    u.nombre = "marica"
    u.save

    return binding
  end
  
  def show(params)
    usuario = Usuarios.find(params[:id].to_i)
    
    return binding
  end
  
end