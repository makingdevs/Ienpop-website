require 'mysql2'
require 'sinatra'
require './lib/ienpop/db_manager'
require './lib/ienpop/models/course'

class CourseManager

  def initialize
    @conn = DBManager.new
  end

  def list
    courses = []

    current_page = 1
    per_page = 10
    records_fetch_point = (current_page - 1) * per_page
    query = "select * from curso  where libreta = 'A' and activo = 1 limit #{per_page} offset #{records_fetch_point}"

    @conn.execute_query(query).each do |row|
      course = Course.new
      course.active = row['clave'],
      course.duration = row['duracion'],
      course.name = row['nombre']
      courses << course
   end
    courses
  end

  def list_courses_notebook_a(limit, offset)
    courses = []
    @conn.execute_query("select * from curso  where libreta = 'A' and activo = 1 limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def list_courses_notebook_b(limit, offset)
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta='B' and activo=1 limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def list_courses_notebook_c(limit, offset)
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta='C' and activo=1 limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def list_courses_notebook_d(limit, offset)
    courses = []
    @conn.execute_query("Select duracion, nombre, description from curso where libreta='D' and activo =  1 limit #{limit} offset #{offset}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def count_courses_notebook(lib)
     num = @conn.execute_query("select COUNT(*) c from curso where libreta = '#{lib}' and activo = 1")
     num.first["c"]
  end

  def list_courses_notebook_certifiction_a
  courses = []
    @conn.execute_query("select * from curso where libreta = 'A' and activo = 1 and (nombre like '%patron%' or nombre like '%capitan%' or nombre like '%motorista%') ").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def list_courses_notebook_certification_b
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta = 'B' and activo = 1 and (nombre like '%patron%' or nombre like '%capitan%' or nombre like '%motorista%')").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def list_course_notebook_certification_c
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta = 'C' and activo = 1 and (nombre like '%patron%' or nombre like '%capitan%' or nombre like '%motorista%')").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

end






