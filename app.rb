require 'sinatra'

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







