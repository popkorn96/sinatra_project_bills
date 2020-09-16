class BillsController < ApplicationController
  configure do
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/bills/new" do
    if is_logged_in?
      @user = current_user
      erb :"/bills/new.html"
    end
    redirect "/login"
  end

  get "/bills" do        
    if is_logged_in?
      @user = current_user
      @bills = Bill.all
      erb :"/bills/index.html"
    else
      redirect "/login"
    end
  end

  post "/bills" do
    @bill = Bill.new(params)
    @user = current_user
    if is_logged_in? && @bill.save 
        @user.bills << @bill
        redirect "/bills/#{@bill.id}"
    else !is_logged_in?
        redirect "/login"
    end
    redirect "/bills/new.html"
  end
  # GET: /bills/5
  get "/bills/:id" do
    @bill = Bill.find_by_id(params[:id])
    @bill.name = params[:name]
    @bill.remaining_balance = params[:remaining_balance]
    @bill.amount_due = params[:amount_due]
    @bill.due_date = params[:due_date]
    if is_logged_in?
      erb :"/bills/show_bill.html"
    else
      redirect "/login"
    end
  end

  # GET: /bills/5/edit
  get "/bills/:id/edit" do
    @user = current_user
    @bill = Bill.find(params[:id])
    if !is_logged_in?
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
  delete "/bills/:id/delete" do
    @bill = Bill.find_by_id(params[:id])
    if is_logged_in? && current_user.bills.include?(@bill)
      @bill.destroy
      redirect "/users/#{current_user.id}"
    else
      redirect "/bills/#{@bill.id}"
    end
  end
end
