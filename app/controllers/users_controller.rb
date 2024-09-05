class UsersController < ApplicationController
  before_action :require_login, except: %i[new create]
  before_action :correct_user, only: [:show]

  def new
    @user = User.new
    @genres = Genre.pluck(:name)
  end

  def show
    @user = find_user
    age_appropriate_movies = age_appropriate_recommendations
    @recommended_movie = age_appropriate_movies.highest_rated_unreviewed_by(@user).first
    @genre_recommended_movie = age_appropriate_movies.unreviewed_movie_of_favorite_genre(@user).first
  end

  def create
    @user = User.new(user_params)
    @genres = Genre.pluck(:name)
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

  def age_appropriate_recommendations
    @user.age_based_movies
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :favorite_genre, :user_name, :password,
                                 :password_confirmation)
  end

  def correct_user
    @user = find_user
    return if @user == current_user

    flash[:alert] = "You are not authorized to view this page."
    redirect_to user_path(current_user)
  end
end
