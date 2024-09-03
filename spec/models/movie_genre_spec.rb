require 'rails_helper'

RSpec.describe MovieGenre, type: :model do
  describe 'associations' do
    it 'belongs to a movie' do
      movie = Movie.create(title: "Test Movie", description: "A test movie", run_time: 120, rating: "PG", release_date: "2024-01-01")
      genre = Genre.create(name: "Action")
      movie_genre = MovieGenre.create(movie: movie, genre: genre)

      expect(movie_genre.movie).to eq(movie)
    end

    it 'belongs to a genre' do
      movie = Movie.create(title: "Test Movie", description: "A test movie", run_time: 120, rating: "PG", release_date: "2024-01-01")
      genre = Genre.create(name: "Action")
      movie_genre = MovieGenre.create(movie: movie, genre: genre)

      expect(movie_genre.genre).to eq(genre)
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      movie = Movie.create(title: "Test Movie", description: "A test movie", run_time: 120, rating: "PG", release_date: "2024-01-01")
      genre = Genre.create(name: "Action")
      movie_genre = MovieGenre.new(movie: movie, genre: genre)

      expect(movie_genre).to be_valid
    end

    it 'is not valid without a movie' do
      genre = Genre.create(name: "Action")
      movie_genre = MovieGenre.new(genre: genre)

      expect(movie_genre).not_to be_valid
      expect(movie_genre.errors[:movie]).to include("must exist")
    end

    it 'is not valid without a genre' do
      movie = Movie.create(title: "Test Movie", description: "A test movie", run_time: 120, rating: "PG", release_date: "2024-01-01")
      movie_genre = MovieGenre.new(movie: movie)

      expect(movie_genre).not_to be_valid
      expect(movie_genre.errors[:genre]).to include("must exist")
    end
  end
end
