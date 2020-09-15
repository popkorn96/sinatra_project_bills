class BillsController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "secret"
  end
  # GET: /bills
  get "/bills" do        
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      @bills = Bill.all
      erb :"/bills/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /bills/new
  get "/bills/new" do
    erb :"/bills/new.html"
  end

  # POST: /bills
  post "/bills" do
    @bill = Bill.new(params)
    @user = Helpers.current_user(session)
    if Helpers.is_logged_in?(session) && !@bill.name.blank? && @bill.save 
        @user.bills << @bill
        redirect "/bills/#{@bill.id}"
    elsif !Helpers.is_logged_in?(session)
        redirect "/login"
    else
        redirect "/bills/new"
    end
  end

  # GET: /bills/5
  get "/bills/:id" do
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    else
      @bill = Bill.find(params[:id])
      erb :"/bills/show.html"
    end
  end

  # GET: /bills/5/edit
  get "/bills/:id/edit" do
    erb :"/bills/edit.html"
  end

#   patch "/tweets/:id" do
#     tweet = Tweet.find(params[:id])
#     if params[:content].empty?
#         redirect "/tweets/#{params[:id]}/edit"
#     end
#     tweet.update(:content => params[:content])
#     tweet.save

#     redirect "/tweets/#{tweet.id}"
# end
  # PATCH: /bills/5
  patch "/bills/:id" do
    redirect "/bills/:id"
  end

  # DELETE: /bills/5/delete
  delete "/bills/:id/delete" do
    redirect "/bills"
  end
end
