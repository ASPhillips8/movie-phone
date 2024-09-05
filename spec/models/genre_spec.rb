require 'rails_helper'

RSpec.describe Genre, type: :model do
  let(:genre) { create(:genre) }

  let(:movie1) { create(:movie, title: "Toy Story") }
  let(:movie2) { create(:movie, title: "Finding Nemo") }

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
      new_genre = create(:genre, name: "Comedy")
      expect(new_genre.popularity).to eq(0)
    end
  end

  context "associations" do
    it "can have many movies" do
      genre.movies << [movie1, movie2]
      expect(genre.movies).to include(movie1, movie2)
    end
  end

  context "methods" do
    describe ".favorite_movie_genre" do
      it "returns the genre with the most users who selected it as their favorite" do
        action = create(:genre, name: "Action")
        horror = create(:genre, name: "Horror")
        drama = create(:genre, name: "Drama")

        create(:user, favorite_genre: "Action", user_name: "john_doe")
        create(:user, favorite_genre: "Action", user_name: "jane_doe")
        create(:user, favorite_genre: "Action", user_name: "jack_smith")
        create(:user, favorite_genre: "Horror", user_name: "jill_smith")
        create(:user, favorite_genre: "Drama", user_name: "drama_lover")

        expect(Genre.favorite_movie_genre).to eq(action)
      end
    end

    describe "#update_genre_popularity_for_movie" do
      it "increases the popularity of the associated genres when a movie is reviewed" do
        action = create(:genre, name: "Action", popularity: 0)
        crime = create(:genre, name: "Crime", popularity: 0)
        movie1 = create(:movie, title: "Movie 1")
        movie2 = create(:movie, title: "Movie 2")

        movie1.genres << action
        movie2.genres << [action, crime]

        user1 = create(:user, user_name: "user1")
        user2 = create(:user, user_name: "user2")

        create(:review, score: 5, comment: "Great action movie!", movie: movie1, user: user1)
        create(:review, score: 4, comment: "Thrilling crime drama!", movie: movie2, user: user1)
        create(:review, score: 3, comment: "Good movie!", movie: movie2, user: user2)

        action.reload
        crime.reload

        expect(action.popularity).to eq(3)
        expect(crime.popularity).to eq(2)
      end
    end
  end
end
