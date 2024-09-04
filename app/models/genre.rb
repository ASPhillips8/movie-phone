class Genre < ApplicationRecord
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  validates :name, presence: true, uniqueness: true

  def self.favorite_movie_genre
    order(popularity: :desc).first
  end
end
