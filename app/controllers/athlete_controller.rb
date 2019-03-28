class AthleteController < ApplicationController

    get '/login' do
      erb :'/athletes/login'
    end

    post '/login' do
      @athlete = Athlete.find_by(:email => params[:email])
        if @athlete && @athlete.authenticate(params[:password])
          session[:user_id] = @athlete.id
          redirect to "/athletes/#{@athlete.id}"
        else
          redirect to '/login'
        end
     end

    get '/signup' do
      erb :'/athletes/new'
    end

    post '/signup' do
      if params[:name].empty? || params[:email].empty? || params[:password].empty?
        redirect to 'athletes/new'
      else
        @athlete = Athlete.create(:name => params[:name], :email => params[:email], :password => params[:password], :age => params[:age],
        :height => params[:height], :weight => params[:weight], :achievement => params[:achievement])
        session[:athlete_id] = @athlete.id
        erb :'/athletes/show'
      end
    end

    get '/athletes' do
      if logged_in?
        @athletes = Athlete.all
        erb :'/athletes/index'
      else
        redirect to '/login'
      end
    end

    get '/athletes/:id' do
      @athlete = Athlete.find(params[:id])
      if logged_in?
        erb :'/athletes/show'
      end
    end

    get '/athletes/:id/edit' do
      @athlete = Athlete.find(params[:id])
      erb :'/athletes/edit'
    end

    patch '/athletes/:id' do
      @athlete = Athlete.find(params[:id])
      if @athlete && logged_in?
        @athlete.name = params[:name]
        @athlete.email = params[:email]
        @athlete.password = params[:password]
        @athlete.age = params[:age]
        @athlete.weight = params[:weight]
        @athlete.height = params[:height]
        @athlete.achievement = params[:achievement]
        @athlete.save
         redirect to "/athletes/#{@athlete.id}"
      else
        redirect to '/login'
      end
    end

    delete '/athletes/:id/delete' do #delete action
      @athlete = Athlete.find_by_id(params[:id])
      @athlete.delete
      redirect to '/signup'
    end

end
