require 'mysql2'
require 'sinatra'
require './lib/sinatra/db_manager'
require './lib/sinatra/models/course'

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

  def showCoursesNotebookA
    courses = []

    current_page = 1
    per_page = 10
    records_fetch_point = (current_page - 1) * per_page

    @conn.execute_query("select * from curso  where libreta = 'A' and activo = 1 limit #{per_page} offset #{records_fetch_point}").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def showCoursesNotebookB
   courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta='B' and activo=1").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def showCoursesNotebookC
    courses = []
    @conn.execute_query("Select duracion, nombre, description  from curso where libreta='C' and activo=1").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def showCoursesNotebookD
    courses = []
    @conn.execute_query("Select duracion, nombre, description from curso where libreta='D' and activo =  1").each do |row|
      course = Course.new
      course.duration = row['duracion'],
      course.name = row['nombre'],
      course.description = row['description']
      courses << course
    end
    courses
  end

  def countCoursesNotebookA
     num = @conn.execute_query("select COUNT(*) from curso where libreta = 'A' and activo = 1")
  end


end



