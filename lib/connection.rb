require 'rubygems'
require "mysql"

module Connection
  
  # Connection se encarga de obtener la conexion con la base de datos

  def Connection.get_connection
    begin
      # connect to the MySQL server
      db = Mysql.real_connect("localhost", "root", "root", "moctezuma",nil, "/Applications/MAMP/tmp/mysql/mysql.sock")
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      return db
    end    
  end

end