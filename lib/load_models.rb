require './lib/connection'

module LoadModels
  
  # LoadModels se encarga de agregarle los atributos a cada modelo
  # dinamicamente obteniendolos de la tabla en la base de datos que
  # tiene el mismo nombre que el modelo
  
  # modelos que cargara
  MODELS = ["Usuarios"]

  def LoadModels.load_models
    
    MODELS.each do |modelo|
      require "./app/models/#{modelo}"
      
      clase = Kernel.const_get(modelo)
    
      variables = []
    
      db = Connection.get_connection    
      res = db.query("SHOW FIELDS FROM `#{modelo}`")
      res.each do |row|
        variables << row[0]
      end
    
      clase.class_eval do
        attr_accessor *variables
      end
    
    end    
  end

end