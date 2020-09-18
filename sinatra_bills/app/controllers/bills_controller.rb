require 'pry'
class BillsController < ApplicationController



  get "/bills" do
    @bills = current_user.bills
    if is_logged_in?
      @user = current_user
      erb :"/bills/index.html"
    else
      redirect "/login"
    end
  end

  get "/bills/new" do
    if !is_logged_in?
      redirect "/login"
    else 
      @user = current_user
      erb :"/bills/new.html"
    end
  end

  post "/bills" do
    @bill = Bill.new(params)
    @user = current_user
    if is_logged_in? && @bill.save
        @user.bills << @bill
        redirect "/bills/#{@bill.id}"
    else
        redirect "/login"
    end
    redirect "/bills/new.html"
  end

  get "/bills/:id" do
    @user = current_user
    @bill = Bill.find(params[:id])
    if @user.id != @bill.user_id
      redirect "/login"
    elsif is_logged_in?
      erb :"/bills/show_bill.html"
    else
      redirect "/login"
    end
  end

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

  patch "/bills/:id" do
    bill = Bill.find(params[:id])
    if params[:name].empty? || params[:remaining_balance].empty? || params[:amount_due].empty? || params[:due_date].empty?
      redirect "bills/#{params[:id]}/edit"
    end
    bill.update(:name => params[:name], :remaining_balance => params[:remaining_balance], :amount_due => params[:amount_due], :due_date => params[:due_date], :category => params[:category])
    bill.save
    redirect "/bills/#{params[:id]}"
  end
  
  delete "/bills/:id/delete" do
    @bill = Bill.find_by_id(params[:id])
    if is_logged_in? && current_user.bills.include?(@bill)
      @bill.destroy
      redirect "/bills"
    else
      redirect "/bills/#{@bill.id}"
    end
  end
end
