require 'sinatra'
require "sinatra/base"
require "sinatra/config_file"
require 'sinatra/flash'
require './lib/ienpop/course_manager'
require './lib/ienpop/managers_manager'
require './lib/ienpop/sedes_manager'
require './lib/ienpop/email_manager'
require './lib/ienpop/testError'
require 'sinatra/reloader'
require 'rack-google-analytics'
require 'recaptcha'

class IENPOP < Sinatra::Base
  register Sinatra::ConfigFile
  register Sinatra::Flash

  enable :sessions

  config_file 'config/config.yml'

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'reloaded'
    end
  end

  include Recaptcha::Verify
  include Recaptcha::ClientHelper



  use Rack::GoogleAnalytics, :tracker => settings.maps['id_analytics']

  def initialize(app = nil, params = {})
    super(app)
    username_db =  settings.db['siyen_username_db']
    host_db =  settings.db['siyen_host_db']
    db =  settings.db['siyen_db']
    password_db =  settings.db['siyen_password_db']
    encoding_db =  settings.db['siyen_encoding_db']

    server_mail =  settings.mail['server_mail']
    port_mail =  settings.mail['port_mail']
    authentication =  settings.mail['authentication']
    user_name = settings.mail['user_name']
    password_mail = settings.mail['password_mail']
    enable_starttls_auto = settings.mail['enable_starttls_auto']
    address_mail = settings.mail['address_mail']

    @site_key = settings.capcha['site_key']
    @secret_key = settings.capcha['secret_key']

    @url_video = settings.url['url_video']
    
    @course_manager = CourseManager.new(username_db, host_db, db, password_db, encoding_db)
    @managers_manager = ManagersManager.new
    @sedes_manager = SedesManager.new
    @email_manager = EmailManager.new(server_mail, port_mail, authentication, user_name, password_mail, enable_starttls_auto, address_mail)
    @error = Error.new

    Recaptcha.configure do |config|
      config.site_key  = @site_key
      config.secret_key = @secret_key
    end
  
  end

  get '/' do
    sinatra = "reload lao"
    @message = params['error']
    erb :index
  end

  get '/home' do
    @logoFlag = false
    @url_video
    erb :index
  end

  get '/about' do
    @logoFlag = true
    erb :about
  end

  get '/contact' do
    @logoFlag = true
    @sedes = @sedes_manager.list_all_sedes
    erb :contact
  end

  get '/sedes' do
    @logoFlag = true
    @managers = @managers_manager.list_all_manager
    @sedes = @sedes_manager.list_all_sedes
    @api_key = settings.maps['api_key']
    erb :sedes
  end

  post '/contact/info' do
    if params['name'].empty? or params['message'].empty? or params['email'].empty? or params['subject'].empty?
      puts "Por favor completa los campos obligatorios"
      flash[:warning] = "Por favor completa los campos obligatorios"
      redirect '/contact'
    elsif  !verify_recaptcha
      puts "El captcha no ha sido verificado!"
      flash[:warning] = "¡El captcha no ha sido verificado!"
      redirect '/contact'
    else
      puts "El captcha es verificado"
      sedes = @sedes_manager.list_all_sedes
      flag = @email_manager.send_email(params,sedes)

      if flag == true
        flash[:success] = "El mensaje fue enviado exitosamente."
      else
        flash[:warning] = "Ocurrio un error al enviar el mensaje."
      end
      redirect '/contact'
    end
  end


  get '/libreta_int_lib' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_notebook('A')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_courses_notebook(limit, offset, 'A')
    erb :"courses/libreta_int_lib"
  end

  get '/libreta_int_cer' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_certification_courses('A')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_course_notebook_certification(limit, offset, 'A')
    erb :"courses/libreta_int_cer"
  end

  get '/turistico_lib' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_notebook('C')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses = @course_manager.list_courses_notebook(limit, offset, 'C')
    erb :"courses/turistico_lib"
  end

  get '/turistico_cer' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_notebook('C')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_course_notebook_certification(limit, offset, 'C')
    erb :"courses/turistico_cer"
  end

  get '/pescadores_lib' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_notebook('B')
    if(count <=  limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_courses_notebook(limit, offset, 'B')
    erb :"courses/pescadores_lib"
  end

  get '/pescadores_cer' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_certification_courses('B')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_course_notebook_certification(limit, offset, 'B')
    erb :"courses/pescadores_cer"
  end

  get '/plataformas_barcasas' do
    @logoFlag = true
    limit = params['limit'] || 10
    page = params['page'] || 0
    count = @course_manager.count_courses_notebook('D')
    if(count <= limit.to_i)
      @flag_show_pagination = false
      @number_pages = 0
    else
      @flag_show_pagination = true
      @number_pages = (count / limit.to_i) + 1
    end
    offset = page.to_i * limit.to_i
    @courses =  @course_manager.list_courses_notebook(limit, offset, 'D')
    erb :"courses/plataformas_barcasas"
  end

  not_found do
    list = @error.testErro()
    erb :"layouts/404"
  end

  error do
      'Sorry there was a nasty error - ' + env['sinatra.error'].message
    erb :"layouts/error"
  end


end

if __FILE__ == $0
      IENPOP.run!
end
