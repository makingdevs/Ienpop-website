require 'mysql2'
require 'sinatra'
require './lib/sinatra/Connection'
require './lib/sinatra/models/course'
class ManagementCourse

  def list
    @conn = Connection.new
    @conn.connect("localhost","", "root", "siyen", "")
    @course = Course.new
    @results = @conn.executeQuery("Select * from curso").each do |row|
      @course.active = row['clave'],
      @course.duration = row['duracion'],
      @course.name = row['nombre']
    end

  end

end



