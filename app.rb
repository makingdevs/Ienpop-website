require 'sinatra'
require './lib/sinatra/course_manager'

class IENPOP < Sinatra::Base

  course_manager = CourseManager.new

  get '/' do
    @message = params['error']
    erb :index
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
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('C')
    if(count < limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses = course_manager.list_courses_notebook_c(limit, offset)
    erb :"courses/turistico_lib"
  end

  get '/turistico_cer' do
    erb :"courses/turistico_cer"
  end

  get '/pescadores_lib' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('B')
    if(count < limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook_b(limit, offset)
    erb :"courses/pescadores_lib"
  end

  get '/pescadores_cer' do
    @courses =  course_manager.list_courses_notebook_b
    erb :"courses/pescadores_cer"
  end

  get '/plataformas_barcasas' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('D')
    if(count < limit.to_i)
      @number_pages = 1
    else
      @number_pages = (count / limit.to_i) + 1
    end

    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook_d(limit, offset)
    erb :"courses/plataformas_barcasas"
  end
end

if __FILE__ == $0
    IENPOP.run!
end


