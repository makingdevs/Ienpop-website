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
    @conn.execute_query("Select * from curso").each do |row|
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
    @conn.execute_query("Select duracion, nombre, description from curso where libreta='A' and activo=1").each do |row|
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

end



