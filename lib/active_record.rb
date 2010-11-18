require './lib/connection'

class ActiveRecord

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

    args = attributes_hash(res).first
    
    return self.build(args)
  end
  
  def self.all
    db = Connection.get_connection
    res = db.query("SELECT * FROM #{self.name}")
    
    args = attributes_hash(res)
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

  # private

  def self.attributes_hash(mysql_res)
    attributes = {}
    attributes_array = []
    db = Connection.get_connection
    res = db.query("SHOW FIELDS FROM `#{self.name}`")

    res.each do |row|
      attributes.merge!({ row[0].to_s => nil })
    end
    res.free
    
    attributes_clone = attributes.clone
    
    mysql_res.each_hash do |row|     
      attributes_array << attributes_clone
      actual = attributes_array.last
      actual.each do |k,v|
        actual[k] = row[k]
      end
      attributes_clone = attributes.clone
    end

    mysql_res.free

    return attributes_array
  end

end