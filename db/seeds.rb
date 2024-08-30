# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"

User.destroy_all

movie_genres = %w[
  Action Comedy Drama Horror Romance Sci-Fi Thriller Fantasy
  Documentary Adventure Animation Mystery
]

# Create five fake users
5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    age: Faker::Number.between(from: 18, to: 80),
    favorite_genre: movie_genres.sample,
    user_name: Faker::Internet.unique.username,
    password: "password",
    password_confirmation: "password"
  )
end

puts "5 fake users created"
