class User < ApplicationRecord
  has_many :reviews
  has_many :movies, through: :reviews

  has_secure_password

  validates :first_name, :last_name, :age, :favorite_genre, :user_name, presence: true
  validates :user_name, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def age_based_movies
    case age
    when 0..12
      Movie.where(rating: %w[G PG])
    when 13..16
      Movie.where(rating: %w[G PG PG-13])
    else
      Movie.all
    end
  end
end
