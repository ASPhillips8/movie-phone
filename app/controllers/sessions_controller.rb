class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]
  def new; end

  def create
    user = User.find_by(user_name: params[:user_name])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:alert] = "Invalid user name or password"
      redirect_to signin_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to signin_path, notice: "Logged out successfully!"
  end

  def redirect_if_logged_in
    return unless current_user

    flash[:notice] = "You are already logged in."
    redirect_to user_path(current_user)
  end
end
