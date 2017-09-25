require 'sinatra'
require './lib/ienpop/course_manager'
require './lib/ienpop/managers_manager'
require './lib/ienpop/sedes_manager'
require './lib/ienpop/email_manager'
require 'sinatra/flash'


class IENPOP < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  course_manager = CourseManager.new
  managers_manager = ManagersManager.new
  sedes_manager = SedesManager.new
  email_manager = EmailManager.new

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
    @sedes = sedes_manager.list_all_sedes
    erb :contact
  end

  get '/sedes' do
    @managers = managers_manager.list_all_manager
    @sedes = sedes_manager.list_all_sedes
    @api_key = ENV["API_KEY"]
    erb :sedes
  end

  post '/contact/info' do
    if params['name'].empty? or params['message'].empty? or params['email'].empty? or params['subject'].empty? 
      puts "Por favor completa los campos obligatorios"
    else
      sedes = sedes_manager.list_all_sedes
      flag = email_manager.send_email(params,sedes)
      if flag == true
        flash[:success] = "Hola Vanessa :D"
      else 
        flash[:warning] = "This is warning"
      end
      redirect '/contact'
    end
  end


  get '/libreta_int_lib' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('A')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook(limit, offset, 'A')
    erb :"courses/libreta_int_lib"
  end

  get '/libreta_int_cer' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_certification_courses('A')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_course_notebook_certification(limit, offset, 'A')
    erb :"courses/libreta_int_cer"
  end

  get '/turistico_lib' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('C')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses = course_manager.list_courses_notebook(limit, offset, 'C')
    erb :"courses/turistico_lib"
  end

  get '/turistico_cer' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('C')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_course_notebook_certification(limit, offset, 'C')
    erb :"courses/turistico_cer"
  end

  get '/pescadores_lib' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('B')
    if(count <=  limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook(limit, offset, 'B')
    erb :"courses/pescadores_lib"
  end

  get '/pescadores_cer' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_certification_courses('B')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_course_notebook_certification(limit, offset, 'B')
    erb :"courses/pescadores_cer"
  end

  get '/plataformas_barcasas' do
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = course_manager.count_courses_notebook('D')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  course_manager.list_courses_notebook(limit, offset, 'D')
    erb :"courses/plataformas_barcasas"
  end
end

if __FILE__ == $0
    IENPOP.run!
end


