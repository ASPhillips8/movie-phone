class MoviesController < ApplicationController
  before_action :require_login, only: %i[index show]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end

private

  def require_login
    return if current_user

    flash[:alert] = "You must be logged in to access this section"
    redirect_to root_path
  end
end
