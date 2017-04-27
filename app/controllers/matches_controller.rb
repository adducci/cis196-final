class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_match, only: [:show, :edit, :update, :destroy]

  # GET /matches
  # GET /matches.json
  def index
    @matches = Match.all
  end

  # GET /matches/1
  # GET /matches/1.json
  def show
  end

  # GET /matches/new
  def new
    @match = Match.new
  end

  def help(name)
    actor = Actor.where('LOWER(name) = ?', name.downcase).first
    unless actor
      actor = Actor.new(name: name)
      if actor.valid_name? && actor.in_database?
        actor.reset_name
        actor.find_tmdb_id
        if actor.save
          actor.add_movies
          return actor
        else
          flash[:notice] = 'something went wrong retrieving actor'
          return nil
        end
      else 
        flash[:notice] = "name invalid or not in database (please check spelling)"
        return nil
      end
    else
      return actor
    end
  end

  # POST /matches
  # POST /matches.json
  def create
    first = Actor.where('LOWER(name) = ?', params[:first].downcase).take
    second = Actor.where('LOWER(name) = ?', params[:second].downcase).take
    if first && second
      first.matches.each do |m|
        @match = m if second.matches.include? m 
      end
    end
    unless @match 
      @match = Match.new
      first = help(params[:first])
      second = help(params[:second])
      if first && second && first.id != second.id
        first.movies.each do |movie|
          @match.movies << movie if second.movies.include? movie
        end
        if @match.save
          @match.actors << first
          @match.actors << second
          if logged_in?
            current_user.matches.append @match unless current_user.matches.include? @match
          end
          redirect_to "/matches/#{@match.id}"
        else
          flash[:notice] = 'something went wrong when searching for matches'
          render :new
        end
      else
        render :new
      end
    else
      if logged_in?
        current_user.matches.append @match unless current_user.matches.include? @match
      end
      redirect_to "/matches/#{@match.id}"
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end
end