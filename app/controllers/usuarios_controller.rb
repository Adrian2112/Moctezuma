require './app/models/usuarios'

class UsuariosController
  
  def index(params)

    return binding
  end
  
  def new(params)
    u = Usuarios.new
    u.nombre = "borre"
    u.email = "b@b.com"
    u.edad = "10"
    u.save
    return binding
  end
  
  def show(params)
    usuario = Usuarios.find(params[:id].to_i)
    
    return binding
  end
  
end