class DatesController < ApplicationController

  # GET: /dat_es
  get "/dat_es" do
    erb :"/dat_es/index.html"
  end

  # GET: /dat_es/new
  get "/dat_es/new" do
    erb :"/dat_es/new.html"
  end

  # POST: /dat_es
  post "/dat_es" do
    redirect "/dat_es"
  end

  # GET: /dat_es/5
  get "/dat_es/:id" do
    erb :"/dat_es/show.html"
  end

  # GET: /dat_es/5/edit
  get "/dat_es/:id/edit" do
    erb :"/dat_es/edit.html"
  end

  # PATCH: /dat_es/5
  patch "/dat_es/:id" do
    redirect "/dat_es/:id"
  end

  # DELETE: /dat_es/5/delete
  delete "/dat_es/:id/delete" do
    redirect "/dat_es"
  end
end
