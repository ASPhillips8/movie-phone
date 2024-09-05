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

# Destroy previous data to avoid duplicates
User.destroy_all
Movie.destroy_all
Genre.destroy_all
MovieGenre.destroy_all
Review.destroy_all

# Define movie genres
movie_genres = %w[
  Action Comedy Drama Horror Romance Sci-Fi Thriller Fantasy
  Documentary Adventure Animation Mystery
]

# Create genres
movie_genres.each do |genre|
  Genre.create!(name: genre)
end

puts "#{movie_genres.count} genres created"

# Create five fake users
15.times do
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

puts "15 fake users created"

# Create 10 fake movies and assign random genres to each
30.times do
  movie = Movie.create!(
    title: Faker::Movie.title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    run_time: Faker::Number.between(from: 60, to: 180),
    rating: %w[G PG PG-13 R].sample,
    release_date: Faker::Date.between(from: "1980-01-01", to: Date.today)
  )

  # Assign 1 to 3 random genres to each movie
  genres = Genre.all.sample(rand(1..3))
  movie.genres << genres
end

puts "30 fake movies created with genres"

# Create reviews for each movie ensuring one review per user per movie
Movie.all.each do |movie|
  # Select a random number of users to leave a review for this movie
  users = User.all.sample(rand(1..5))

  users.each do |user|
    Review.create!(
      score: Faker::Number.between(from: 0, to: 10),
      comment: Faker::Lorem.sentence(word_count: 10),
      user: user,
      movie: movie
    )
  end
end

puts "Reviews created for each movie"
