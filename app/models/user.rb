class User < ApplicationRecord
  has_many :reviews
  has_many :movies, through: :reviews

  has_secure_password

  validates :first_name, :last_name, :age, :favorite_genre, :user_name, presence: true
  validates :user_name, uniqueness: true
end
