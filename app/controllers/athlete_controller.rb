class AthleteController < ApplicationController

    get '/login' do
      if !logged_in?
        erb :'/athletes/login'
      else
       redirect to "/athletes/#{current_user.id}"
     end
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
      if !logged_in?
        erb :'/athletes/new'
      else
        redirect to '/'
      end
    end

    post '/signup' do
      if empty_params?
        redirect to '/signup'
      else
        @athlete = Athlete.create(params)
        session[:user_id] = @athlete.id
        # flash[:message] = "New Account Successful"
        redirect to "/athletes/#{@athlete.id}"
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
      if logged_in?
        @athlete = Athlete.find(params[:id])
        erb :'/athletes/show'
      end
    end

    get '/athletes/:id/edit' do
      @athlete = Athlete.find(params[:id])
      if @athlete == current_user
       erb :'/athletes/edit'
     else
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
        if @athlete && logged_in? && current_user == @athlete
          params.delete('_method')
          @athlete.delete
           redirect to '/signup'
        else
          redirect to '/athletes/show'
       end
     end

end
