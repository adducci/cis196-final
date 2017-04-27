class SessionsController < ApplicationController
  # GET /sessions/new
  def new
  end

  # POST /sessions
  def create
    @user = User.find_by(name: params[:name])
    if @user && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to '/login'
    end
  end

  # DELETE /sessions
  def destroy
    reset_session
    redirect_to '/'
  end
end
