class ActiveRecord
  
  # ActiveRecord se encarga de crear los objetos en la base de datos y
  # de mapear los atributos de la base de datos a un objecto
  # 
  # Todos los modelos deben heredar de ActiveRecord
  # 

  def self.build(args)
    clase = self.new
    args.each do |k,v|
      clase.send("#{k}=", v)
    end
    return clase
  end

  def self.find(id)
    db = Connection.get_connection
    res = db.query("SELECT * FROM #{self.name} WHERE id = #{id} LIMIT 1")

    args = attributes_array(res, db).first
    
    return self.build(args)
  end
  
  def self.all
    db = Connection.get_connection
    res = db.query("SELECT * FROM #{self.name}")
    
    args = attributes_array(res, db)
    objects = []
    args.each do |hash|
      objects << self.build(hash)
    end
    
    return objects
  end

  def save
    attributes_hash = {}
    db = Connection.get_connection
    fields = db.query("SHOW FIELDS FROM `#{self.class}`")

    fields.each do |row|
      attributes_hash.merge!({ row[0].to_s => self.send(row[0]) })
    end

    id = attributes_hash.delete("id") 
    if attributes_hash.id == nil
      fields_names = attributes_hash.collect{|k, v| k}.join(",")
      fields_values = attributes_hash.collect{|k, v| "'" + v.to_s + "'"}.join(",")
      query = "INSERT INTO #{self.class} (#{fields_names}) VALUES (#{fields_values})"
    else
      values = attributes_hash.collect{|k ,v | "#{k}='#{v}'"}.join(",")
      query = "UPDATE #{self.class} SET #{values} WHERE id = #{id}"

    end
    db.query(query)
    fields.free
    
  end

  private

  def self.attributes_array(mysql_res, db)
    attributes_array = []
    attributes = {}
    res = db.query("SHOW FIELDS FROM `#{self.name}`")

    res.each do |row|
      attributes.merge!({ row[0].to_s => nil })
    end
    res.free
    
    mysql_res.each_hash do |row|     
      attributes_array << attributes_hash(attributes, row)
    end

    mysql_res.free

    return attributes_array
  end
  
  def self.attributes_hash(attributes, row)
    attributes = attributes.clone
    
    attributes.each do |k,v|
      attributes[k] = row[k]
    end
    
    return attributes
  end

end