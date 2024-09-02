class MoviesController < ApplicationController
  before_action :require_login, only: %i[index show]
  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
