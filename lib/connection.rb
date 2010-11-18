require 'rubygems'
require 'mysql'
require 'yaml'

module Connection
  
  # Connection se encarga de obtener la conexion con la base de datos

  def Connection.get_connection
    connection = read_database_config_file
    begin
      # connect to the MySQL server
      db = Mysql.real_connect(connection["host"], connection["user"], connection["password"],
                              connection["database"],connection["port"], connection["socket"])
    rescue Mysql::Error => e
      puts "Error code: #{e.errno}"
      puts "Error message: #{e.error}"
      puts "Error SQLSTATE: #{e.sqlstate}" if e.respond_to?("sqlstate")
    ensure
      return db
    end    
  end
  
  private
  
  def Connection.read_database_config_file
    begin
      config = YAML.load_file("config/database.yml")
      return config
    rescue Errno::ENOENT
      puts "Error. config/database.yml no existe"
    end
  end

end