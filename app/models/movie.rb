class Movie < ApplicationRecord
  has_many :reviews
  has_many :users, through: :reviews

  validates :title, :description, :rating, :release_date, presence: true
  validates :run_time, numericality: { only_integer: true, greater_than: 0 }

  def average_score
    reviews.average(:score).to_f.round(2)
  end

  def formatted_release_date
    release_date.strftime("%B %d, %Y")
  end
end
