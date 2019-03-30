class TeamController < ApplicationController

  get '/teams/new' do
    # @athlete = Athlete.find(params[:id])
    if logged_in?
       erb :'/teams/new_team'
     else
      redirect to '/login'
     end
  end

  post '/teams' do
    #must be logged in at this point
    if params[:name].empty? || params[:sport_type].empty?
      redirect to '/teams/new'
    else
      @team = Team.create(:name => params[:name], :sport_type => params[:sport_type], :athlete_id => current_user.id)
      redirect to "/teams/#{@team.id}"
    end
  end

  get '/teams/:id' do
    @team = Team.find(params[:id])
    erb :'/teams/show'
  end


  # post '/teams' do
  #   #must be logged in at this point
  #   @team = Team.create(:name => params[:name], :sport_type => params[:sport_type], :athlete_id => current_user.id)
  #   redirect to "/teams/#{@team.id}"
  # end
  #

end
