class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_movie
  def new
    @review = @movie.reviews.build(user: current_user)
  end

  def create
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_path(@movie)
    else
      render :new
    end
  end

private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:score, :comment, :movie_id, :user_id)
  end
end
