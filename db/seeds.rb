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
Movie.destroy_all
Review.destroy_all

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

# Create 10 fake movies
10.times do
  Movie.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    run_time: Faker::Number.between(from: 60, to: 180), # Adjusted runtime to be between 60 and 180 minutes
    rating: %w[G PG PG-13 R].sample,
    release_date: Faker::Date.between(from: "1980-01-01", to: Date.today)
  )
end

puts "10 fake movies created"

# Create reviews for each movie ensuring one review per user per movie
Movie.all.each do |movie|
  # Select a random number of users to leave a review for this movie
  users = User.all.sample(rand(1..5))

  users.each do |user|
    Review.create!(
      score: Faker::Number.between(from: 0, to: 10), # Adjusted score to be between 0 and 10
      comment: Faker::Lorem.sentence(word_count: 10),
      user: user,
      movie: movie
    )
  end
end

puts "Reviews created for each movie"
