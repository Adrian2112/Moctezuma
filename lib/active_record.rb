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
     
     args = attributes_hash(res)
     return self.build(args)
   end
   
   def save
      
   end
   
   def my_class
      self.class
   end 
   
   private
   
   def self.attributes_hash(mysql_res)
     attributes_hash = {}
     db = Connection.get_connection
     res = db.query("SHOW FIELDS FROM `#{self.name}`")
     
     res.each do |row|
       attributes_hash.merge!({ row[0].to_s => nil })
     end
     res.free
     
     mysql_res.each_hash do |row|     
        
      attributes_hash.each do |k,v|
        attributes_hash[k] = row[k]
      end
            
     end
     
     mysql_res.free
     
     return attributes_hash
   end
   
end