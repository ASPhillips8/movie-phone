class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(user_name: params[:user_name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path
    else
      flash[:alert] = "Invalid name or passwrod"
      render :new
    end
  end

  def destroy
  end
end
