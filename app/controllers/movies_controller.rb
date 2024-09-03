class MoviesController < ApplicationController
  before_action :require_login, only: %i[index show]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
    @user_review = @movie.reviews.find_by(user: current_user)
    @other_reviews = @movie.reviews.exluding_user(current_user)
  end
end
