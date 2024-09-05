class MoviesController < ApplicationController
  before_action :require_login, only: %i[index show]
  def index
    @genres = Genre.all
    @movies = age_filtered_movies
    @movies = @movies.search_and_filter(query: params[:query], genre_id: params[:genre_id])
  end

  def show
    @movie = Movie.find(params[:id])
    @user_review = @movie.reviews.find_by(user: current_user)
    @other_reviews = @movie.reviews.exluding_user(current_user)
  end

private

  def age_filtered_movies
    current_user.age_based_movies
  end
end
