class TeamController < ApplicationController

  get '/teams/new' do
    if logged_in?
       erb :'/teams/new_team'
     else
      redirect to '/login'
     end
  end

  post '/teams' do
    if params[:name].empty? || params[:sport_type].empty?
      redirect to '/teams/new'
    else
      @team = Team.create(:name => params[:name], :sport_type => params[:sport_type], :athlete_id => session[:user_id])
      redirect to "/teams/#{@team.id}"
    end
  end

  get '/teams/:id' do
    @team = Team.find(params[:id])
    erb :'/teams/show'
  end

end
