class ApplicationController < Sinatra::Base
  configure do
  set :public_folder, 'public'
  set :views, 'app/views'
  enable :sessions
  set :session_secret, "password_security"
end

  get '/' do
    erb :index
  end

  get '/logout' do
    session.clear
    redirect to '/login'
end


  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      Athlete.find(session[:user_id])

      # @athlete = Athlete.find(params[:id])
      # session[:user_id] = @athlete.id
    end

    def empty_params?
      params.values.any?{|val| val.empty?}
    end

 end

end
