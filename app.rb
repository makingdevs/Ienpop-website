require 'sinatra'
require './lib/sinatra/course_manager'

class IENPOP < Sinatra::Base

  course_manager = CourseManager.new
  get '/frank-says' do
    'Put this in your pipe & smoke it!'
  end

  get '/' do
    @message = params['error']
    erb :index
  end

  post '/Otra/contact/:p' do
    puts "#{params}"
    @saludo = "Hola "
    @nombres = "#{params['p']} #{params['name']}"
    if params['name'].empty?
      redirect "/?error=esta vacio"
    else
      erb :Otra
    end
  end

  get '/home' do
    erb :index
  end

  get '/about' do
    erb :about
  end

  get '/contact' do
    erb :contact
  end

  get '/sedes' do
    erb :sedes
  end

  get '/libreta_int_lib' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('A')
    @number_pages = (count / limit.to_i) + 1
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook_a(limit, offset)
    erb :"courses/libreta_int_lib"
  end

  get '/libreta_int_cer' do
    @courses =  course_manager.list_courses_notebook_a
    puts @courses
    erb :"courses/libreta_int_cer"
  end

  get '/turistico_lib' do
    erb :"courses/turistico_lib"
  end

  get '/turistico_cer' do
    erb :"courses/turistico_cer"
  end
  get '/pescadores_lib' do
    @courses =  course_manager.list_courses_notebook_b
    erb :"courses/pescadores_lib"
  end
  get '/pescadores_cer' do
    @courses =  course_manager.list_courses_notebook_b
    erb :"courses/pescadores_cer"
  end

  get '/plataformas_barcasas' do
    erb :"courses/plataformas_barcasas"
  end
end

if __FILE__ == $0
    IENPOP.run!
end


