require './config/environment'

class ApplicationController < Sinatra::Base
  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get "/" do
    redirect "/index"
  end
  
  get "/index" do 
    @session = session
    erb :index
  end
  
end
