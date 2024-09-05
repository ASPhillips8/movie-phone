class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  has_many :movie_genres, dependent: :destroy
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

  def self.search_and_filter(query:, genre_id:)
    search(query).filter_by_genre(genre_id)
  end

  def self.search(query)
    return all unless query.present?

    where("title LIKE ?", "%#{query}%")
  end

  def self.filter_by_genre(genre_id)
    return all unless genre_id.present?

    joins(:genres).where(genres: { id: genre_id })
  end

  def average_score
    reviews.average(:score).to_f.round(2)
  end

  def formatted_release_date
    release_date.strftime("%B %d, %Y")
  end
end
