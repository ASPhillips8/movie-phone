class UsersController < ApplicationController
  before_action :require_login, except: %i[new create]
  before_action :correct_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = find_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Successfully signed up!"
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :favorite_genre, :user_name, :password,
                                 :password_confirmation)
  end

  def require_login
    return if current_user

    flash[:alert] = "You must be logged in to access this section"
    redirect_to root_path
  end

  def correct_user
    @user = find_user
    return if @user == current_user

    flash[:alert] = "You are not authorized to view this page."
    redirect_to user_path(current_user)
  end
end
