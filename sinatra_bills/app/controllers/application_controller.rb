require './config/environment'

class ApplicationController < Sinatra::Base
  

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    # set :method_override, true
  end

  get "/" do
    redirect "/index"
  end
  
  get "/index" do 
    @session = session
    erb :index
  end
  helpers do
    def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
    end
    def is_logged_in?
      !!current_user
    end
  end
  
end
