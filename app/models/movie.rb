class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  has_many :movie_genres
  has_many :genres, through: :movie_genres

  validates :title, :description, :rating, :release_date, presence: true
  validates :run_time, numericality: { only_integer: true, greater_than: 0 }

  scope :highest_rated_unreviewed_by, ->(user) {
    left_joins(:reviews)
      .group(:id)
      .where.not(id: user.reviews.select(:movie_id))
      .order(Arel.sql("COALESCE(AVG(reviews.score), 0) DESC"))
  }

  scope :unreviewed_movie_of_favorite_genre, ->(user) {
    joins(:genres)
      .where(genres: { name: user.favorite_genre })
      .where.not(id: user.reviews.select(:movie_id))
  }

  def self.search_by_title(query)
    if query
      where("title LIKE ?", "%#{query}%")
    else
      all
    end
  end

  # def self.filter_by_genre(genre_id)
  #   if genre_id.present?
  #     joins(:genres).where(genres: { id: genre_id })
  #   else
  #     all
  #   end
  # end

  def average_score
    reviews.average(:score).to_f.round(2)
  end

  def formatted_release_date
    release_date.strftime("%B %d, %Y")
  end
end
