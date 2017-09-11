require 'mysql2'
require 'sinatra'
require './lib/ienpop/db_manager'
require './lib/ienpop/models/course'

class CourseManager

  def initialize
    @conn = DBManager.new
  end

  def list_courses_notebook(limit, offset, notebook)
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta='#{notebook}' and activo=1 and (nombre not  like '%patron%' and nombre not like '%capitan%'  and nombre not like '%motorista%') limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def count_courses_notebook(lib)
     num = @conn.execute_query("select COUNT(*) c from curso where libreta = '#{lib}' and activo = 1 and (nombre not  like '%patron%'  and nombre not like '%capitan%' and nombre not like '%motorista%')")
     num.first["c"]
  end

  def count_courses_certification_courses(lib)
    num = @conn.execute_query("select COUNT(*) c from curso where libreta = '#{lib}' and activo = 1 and (nombre like '%patron%' or nombre like '%capitan%' or nombre like '%motorista%')")
    num.first["c"]
  end


  def list_course_notebook_certification(limit, offset, notebook)
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta = '#{notebook}' and activo = 1 and (nombre like '%patron%' or nombre like '%capitan%' or nombre like '%motorista%') limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses

  end

end






