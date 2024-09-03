require 'rails_helper'

RSpec.describe Genre, type: :model do
  let(:genre) { Genre.create(name: "Animation", popularity: 10) }

  let(:movie1) do
    Movie.create(
      title: "Toy Story",
      description: "A story about toys that come to life when humans aren't around.",
      run_time: 81,
      rating: "G",
      release_date: "1995-11-22"
    )
  end

  let(:movie2) do
    Movie.create(
      title: "Finding Nemo",
      description: "A clownfish sets out on a journey to find his son.",
      run_time: 100,
      rating: "G",
      release_date: "2003-05-30"
    )
  end

  let(:user1) do
    User.create(
      first_name: "Anthony",
      last_name: "Lumpenstein",
      age: 35,
      favorite_genre: "Animation",
      user_name: "Lumpy3",
      password: "password1",
      password_confirmation: "password1"
    )
  end

  let(:user2) do
    User.create(
      first_name: "Sarah",
      last_name: "Test",
      age: 30,
      favorite_genre: "Animation",
      user_name: "SarahT",
      password: "password2",
      password_confirmation: "password2"
    )
  end

  context "validations" do
    it "is valid with a name and popularity" do
      expect(genre).to be_valid
    end

    it "is invalid without a name" do
      genre.name = nil
      expect(genre).not_to be_valid
      expect(genre.errors[:name]).to include("can't be blank")
    end

    it "has a default popularity of 0" do
      new_genre = Genre.create(name: "Comedy")
      expect(new_genre.popularity).to eq(0)
    end
  end

  context "associations" do
    it "can have many movies" do
      genre.movies << [movie1, movie2]
      expect(genre.movies).to include(movie1, movie2)
    end

    it "can have many users who favor this genre" do
      expect(user1.favorite_genre).to eq("Animation")
      expect(user2.favorite_genre).to eq("Animation")
    end
  end

  context "methods" do
    describe ".favorite_genre" do
      it "returns the most popular genre based on user selections" do
        action = Genre.create(name: "Action")
        horror = Genre.create(name: "Horror")
        crime = Genre.create(name: "Crime")

        User.create(first_name: "John", last_name: "Doe", age: 30, favorite_genre: "Action", user_name: "john_doe", password: "password")
        User.create(first_name: "Jane", last_name: "Doe", age: 25, favorite_genre: "Action", user_name: "jane_doe", password: "password")
        User.create(first_name: "Jack", last_name: "Smith", age: 28, favorite_genre: "Action", user_name: "jack_smith", password: "password")
        User.create(first_name: "Jill", last_name: "Smith", age: 27, favorite_genre: "Horror", user_name: "jill_smith", password: "password")
        User.create(first_name: "Jake", last_name: "Johnson", age: 32, favorite_genre: "Crime", user_name: "jake_johnson", password: "password")

        expect(Genre.favorite_genre).to eq(action)
      end
    end

    describe "#update_genre_popularity_for_movie" do
      it "increases the popularity of the genre when a movie is reviewed" do
        genre.movies << movie1
        Review.create(score: 5, comment: "Great movie!", movie: movie1, user: user1)
        expect(genre.reload.popularity).to eq(11)
      end
    end
  end
end

