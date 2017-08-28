require 'sinatra'

class IENPOP < Sinatra::Base
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
    erb :"courses/libreta_int_lib" 
  end
  
  get '/libreta_int_cer' do
    erb :"courses/libreta_int_cer"
  end
  
  get '/turistico_lib' do
    erb :"courses/turistico_lib"
  end
  
  get '/turistico_cer' do 
    erb :"courses/turistico_cer"
  end
  get '/pezcadores_lib' do
    erb :"courses/pezcadores_lib"
  end
  
  get '/pezcadores_cer' do 
    erb :"courses/pezcadores_cer"
  end
  get '/plataformas_barcasas' do
    erb :"courses/plataformas_barcasas"
  end
end

if __FILE__ == $0
    IENPOP.run!
end