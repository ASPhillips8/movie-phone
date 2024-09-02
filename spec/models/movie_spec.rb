require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) do
    described_class.new(
      title: "Toy Story",
      description: "A story about toys that come to life when humans aren't around.",
      run_time: 81,
      rating: "G",
      release_date: "1995-11-22"
    )
  end

  context "validations" do
    it "is valid with all attributes present" do
      expect(movie).to be_valid
    end

    %i[title description rating release_date].each do |attr|
      it "is invalid without a #{attr.to_s.humanize.downcase}" do
        movie.send("#{attr}=", nil)
        expect(movie).not_to be_valid
        expect(movie.errors[attr]).to include("can't be blank")
      end
    end

    it "is invalid without a run time" do
      movie.run_time = nil
      expect(movie).not_to be_valid
      expect(movie.errors[:run_time]).to include("is not a number")
    end

    it "is invalid if run time is not a positive integer" do
      movie.run_time = -10
      expect(movie).not_to be_valid
      expect(movie.errors[:run_time]).to include("must be greater than 0")
    end
  end

  describe 'associations' do
    it 'can have many reviews' do
      movie.save!

      review1 = movie.reviews.create!(score: 5, comment: 'Amazing movie!', user: User.create(first_name: "User1", last_name: "Test", user_name: "user1", password: "password", age: 25, favorite_genre: "Animation"))
      review2 = movie.reviews.create!(score: 4, comment: 'Really enjoyed it', user: User.create(first_name: "User2", last_name: "Test", user_name: "user2", password: "password", age: 30, favorite_genre: "Comedy"))

      expect(movie.reviews).to include(review1, review2)
    end

    it 'can have many users through reviews' do
      movie.save!

      user1 = User.create(first_name: "User1", last_name: "Test", user_name: "user1", password: "password", age: 25, favorite_genre: "Animation")
      user2 = User.create(first_name: "User2", last_name: "Test", user_name: "user2", password: "password", age: 30, favorite_genre: "Comedy")
      review1 = movie.reviews.create!(score: 5, user: user1)
      review2 = movie.reviews.create!(score: 4, user: user2)

      expect(movie.users).to include(user1, user2)
    end

    it 'can have many genres' do
      movie.save!

      genre1 = Genre.create(name: 'Animation')
      genre2 = Genre.create(name: 'Family')
      movie.genres << [genre1, genre2]

      expect(movie.genres).to include(genre1, genre2)
    end
  end

  context "methods" do
    describe "#average_score" do
      it "calculates the average score of the movie" do
        movie.save!

        user1 = User.create(first_name: "User1", last_name: "Test", user_name: "user1", password: "password", age: 25, favorite_genre: "Animation")
        user2 = User.create(first_name: "User2", last_name: "Test", user_name: "user2", password: "password", age: 30, favorite_genre: "Comedy")

        Review.create!(score: 5, user: user1, movie: movie)
        Review.create!(score: 3, user: user2, movie: movie)

        expect(movie.average_score).to eq(4.0)
      end
    end

    describe "#formatted_release_date" do
      it "returns the release date in the format 'November 22, 1995'" do
        expect(movie.formatted_release_date).to eq("November 22, 1995")
      end
    end
  end
end
