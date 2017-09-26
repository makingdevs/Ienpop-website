require 'mysql2'

class DBManager 
  
  def initialize(username_db, host_db, db, password_db, encoding_db)
    @client = Mysql2::Client.new(
      :username => username_db,
      :host => host_db,
      :database => db,
      :password => password_db,
      :encoding => encoding_db || "utf8"
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


