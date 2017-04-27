class ActorsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_actor, only: [:show, :destroy]

  # GET /actors/1
  # GET /actors/1.json
  def show
  end


  # GET /actors/new
  def new
    @actor = Actor.new
    if !logged_in?
      redirect_to '/'
    end
  end

  # POST /actors
  # POST /actors.json
  def create
    @actor = Actor.where('LOWER(name) = ?', params[:name].downcase).first
    unless @actor
      @actor = Actor.new(name: params[:name])
      if @actor.valid_name? && @actor.in_database?
        @actor.reset_name
        @actor.find_tmdb_id
        if @actor.save
          @actor.add_movies
          current_user.actors.append @actor unless current_user.actors.include? @actor
          redirect_to current_user
        else 
          flash[:notice] = 'invalid actor'
          redirect_to '/actors'
        end
      else 
        flash[:notice] = 'name invalid or not in database (please check spelling)'
        redirect_to '/actors'
      end
    else
      current_user.actors.append @actor unless current_user.actors.include? @actor
      redirect_to current_user
    end
  end

  # DELETE /actors/1
  # DELETE /actors/1.json
  def destroy
    current_user.actors.delete(@actor)
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_actor
      @actor = Actor.find(params[:id])
    end
end