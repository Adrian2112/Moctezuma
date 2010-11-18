module Router
  
  # Router se encarga de separar la url de la peticion para obtener
  # el controlador, la acion, el id y los demas parametros que se
  # se manden por medio de los metodos GET o POST.
  #
  # Regresa los parametros dentro de un hash siendo siempre la llave
  # un simbolo y el valor un string
  # 
  #   Ejemplo.
  #     { :controller => 'usuario', :action => 'index', :id => nil }
  # 
  # Solo las acciones show y edit tienen un id diferente de nil
  # 
  
  def Router.get_params(request)
    # quita el primer slash para generar la routa
    route = request.path[1..-1]
    splitted = route.split("/")
    
    if splitted.empty?
      params = { :controller => "index", :action => "index", :id => nil }
    elsif splitted.size == 1
      params = { :controller => splitted[0], :action => "index", :id => nil }
    elsif splitted[1].to_i != 0
      params = { :controller => splitted[0], :action => "show", :id => splitted[1]}
    else
      params = { :controller => splitted[0], :action => splitted[1], :id => splitted[2]}
    end
    
    # agrega los demas paramteros mandados por GET o POST    
    params.merge! request.query
    
    return params
  end
  
end