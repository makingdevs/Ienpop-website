require 'mysql2'
require 'sinatra'
require './lib/sinatra/Connection'
require './lib/sinatra/models/course'

class CourseManager

  def initialize
    @conn = Connection.new
  end

  def list
    courses = []
    conn.executeQuery("Select * from curso").each do |row|
      course = Course.new
      course.active = row['clave'],
      course.duration = row['duracion'],
      course.name = row['nombre']
      courses << course
    end
    courses
  end

end



