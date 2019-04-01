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
      if empty_params?
        redirect to '/signup'
      else
        @athlete = Athlete.create(params)
        session[:athlete_id] = @athlete.id
        # erb :'/athletes/show'
        redirect to "/athletes/#{@athlete.id}"
      end
    end

    get '/athletes' do
      if logged_in?
        @athlete = Athlete.find(params[:id])
        # binding.pry
        # redirect to :"/athletes/#{@athlete.id}"
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
      @athlete = Athlete.find(current_user.id)
      if @athlete == current_user
       erb :'/athletes/edit'
     else
      #  "You cannot edit someone else's profile."
       redirect to '/athletes/show'
     end
    end

    patch '/athletes/:id' do
      @athlete = Athlete.find(current_user.id)
      if empty_params?
        redirect to '/athletes/:id/edit'
      elsif @athlete && logged_in? && current_user == @athlete
        params.delete('_method')
        @athlete.update(params)
        @athlete.save
         redirect to "/athletes/#{@athlete.id}"
      else
        redirect to '/login'
      end
    end

    delete '/athletes/:id/delete' do
      @athlete = Athlete.find_by_id(params[:id])
        if @athlete.id == session[:id]
          @athlete.delete
          redirect to '/signup'
       else
        #  "You cannot Delete someone else's profile."
          redirect to '/athletes/show'
       end
     end

end
