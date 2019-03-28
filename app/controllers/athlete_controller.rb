class AthleteController < ApplicationController

  get '/login' do
    @athletes = Athlete.all
    erb :'/athletes/index'
  end

  post '/login' do
    @athlete = Athlete.find(params[:id])

  end

  get '/athletes/new' do
    erb :'/athletes/new'
  end

  post '/athletes' do
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      redirect to 'athletes/new'
    else
      @athlete = Athlete.create(:name => params[:name], :email => params[:email], :password => params[:password], :age => params[:age],
      :height => params[:height], :weight => params[:weight], :achievement => params[:achievement])

      session[:athlete_id] = @athlete.id
      erb :'/athletes/show'
    end
  end

end
