class UsersController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "secret"
  end
  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  get "/signup" do
    erb :"/users/signup"
  end

  post "/signup" do
    if params[:username] == "" || params[:email] =="" || params[:password] == ""
      redirect "/signup"
    else 
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/bills/index"
    end
  end
  get "/login" do 
    if !is_logged_in?
      erb :"/users/login"
    else
      redirect "/bills"
    end
  end
  post "/login" do 
    @session = session
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/bills/index"
    end
    redirect "/signup"
  end
  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
  end
  get "/logout" do
    if !is_logged_in?
        redirect "/login"
    else
        session.clear
        redirect "/login"
    end
  end
end
