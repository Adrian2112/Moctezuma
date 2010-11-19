class UsuariosController < ActionController
  
  def index
    @usuarios = Usuarios.all
    
  end
  
  def new
    @usuario = Usuarios.new
  end
  
  def create
    @usuario = Usuarios.new
    @usuario.nombre = params["nombre"]
    @usuario.edad = params["edad"]
    @usuario.email = params["email"]
    @usuario.save
    redirect_to "/usuarios/#{@usuario.id}"
  end
  
  def show
    @usuario = Usuarios.find(params[:id].to_i)
    
  end
  
  def edit
    @usuario = Usuarios.find(params[:id].to_i)
  end
  
  def update
    @usuario = Usuarios.find(params[:id].to_i)
    @usuario.nombre = params["nombre"]
    @usuario.edad = params["edad"]
    @usuario.email = params["email"]
    @usuario.save
    redirect_to "/usuarios/#{@usuario.id}"
  end
  
  def logger(params)
    string_params = "{ "
    params.each { |k,v| string_params << ":#{k} => '#{v}', " }
    string_params = string_params[0..-3]
    string_params << " } "
    puts string_params
  end
  
end