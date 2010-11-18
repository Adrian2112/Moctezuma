class UsuariosController < ActionController
  
  def index
    @usuarios = Usuarios.all
    
  end
  
  def new
    @usuario = Usuarios.find(1)
  end
  
  def show
    @usuario = Usuarios.find(params[:id].to_i)
    
  end
  
end