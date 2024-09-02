class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  validates :title, presence: true
  validates :description, presence: true
  validates :run_time, numericality: { only_integer: true, greater_than: 0 }
  validates :rating, presence: true
  validates :release_date, presence: true
end
