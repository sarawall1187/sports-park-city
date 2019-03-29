class TeamController < ApplicationController

  get '/teams/new' do
    erb :'/teams/new_team'
  end

  get '/teams/:id' do
    @team = Team.find(params[:id])
    erb :'/teams/show'
  end


  post '/teams' do
    #must be logged in at this point
    @team = Team.create(:name => params[:name], :sport_type => params[:sport_type], :athlete_id => current_user.id)
    redirect to "/teams/#{@team.id}"
  end


end
