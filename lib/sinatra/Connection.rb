require 'mysql2'
require 'sinatra'

class Connection
  def connect(dbhost, dbport, dbuser, dbname, dbpass)
    @client = Mysql2::Client.new(
      :host => dbhost,
      :port => dbport,
      :username => dbuser,
      :database => dbname,
      :password => dbpass,
      :encoding => 'utf8'
    )
  end

  def executeQuery(stmt)
    @client.query(stmt)
  end

end