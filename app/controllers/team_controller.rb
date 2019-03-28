class TeamController < ApplicationController

  get '/teams/new' do
    erb :'/teams/new_team'
  end

  post '/teams' do
    @team = Team.create(:name => params[:name], :sport_type => params[:sport_type])
    session[:athlete_id] = @team.id
    erb :'/teams/show'
  end
end
