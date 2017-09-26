require 'mysql2'

class DBManager 
  
  def initialize(username_db, host_db, db, password_db, encoding_db)
    @client = Mysql2::Client.new(
      :username => ENV["SIYEN_USERNAME_DB"],
      :host => ENV["SIYEN_HOST_DB"],
      :database => ENV["SIYEN_DB"],
      :password => ENV["SIYEN_PASSWORD_DB"],
      :encoding => ENV["SIYEN_ENCODING_DB"] || "utf8"
    )
  end

  def execute_query(stmt)
    @client.query(stmt)
  end

  def execute_insert
  end

  def execute_delete
  end

  def execute_update
  end

  def execute_store_procedure
  end

  def execute_view
  end

end


