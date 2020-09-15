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
    if Helpers.is_logged_in?(session)
      @bill = Bill.find(params[:id])
      erb :"/bills/show.html"
    else
      redirect "/login"
    end
  end

  # GET: /bills/5/edit
  get "/bills/:id/edit" do
    @user = Helpers.current_user(session)
    @bill = Bill.find(params[:id])
    if !Helpers.is_logged_in?(session)
      redirect "/login"
    end
    if @user.id != @bill.user_id
      redirect "/login"
    end
    erb :"/bills/edit.html"
  end

  # PATCH: /bills/5
  patch "/bills/:id" do
    bill = Bill.find(params[:id])
    if params[:name].empty? || params[:remaining_balance].empty? || params[:amount_due].empty? || params[:due_date].empty?
      redirect "bills/#{params[:id]}/edit"
    end
    bill.update(:name => params[:name], :remaining_balance => params[:name], :amount_due => params[:amount_due], :due_date => params[:due_date])
    bill.save
    redirect "/bills/#{params[:id]}"
  end
  # DELETE: /bills/5/delete
  delete "/bills/:id" do
    @bill_to_destroy = Bill.find(params[:id])
    @bill_to_destroy.destroy
    redirect "/bills"
  end
end
