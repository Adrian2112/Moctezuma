require './lib/connection'

module LoadModels
  
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