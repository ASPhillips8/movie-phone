require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) do
    User.create(
      first_name: "Anthony",
      last_name: "Lumpenstein",
      age: 35,
      favorite_genre: "Horror",
      user_name: "Lumpy3",
      password: "password1",
      password_confirmation: "password1"
    )
  end

  let(:movie) do
    Movie.create(
      title: "Toy Story",
      description: "A story about toys that come to life when humans aren't around.",
      run_time: 81,
      rating: "G",
      release_date: "1995-11-22"
    )
  end

  let(:review) do
    Review.new(
      score: 8,
      comment: "Amazing movie!",
      user: user,
      movie: movie
    )
  end

  context "validations" do
    it "is valid with all attributes present" do
      expect(review).to be_valid
    end

    it "is invalid without a score" do
      review.score = nil
      expect(review).not_to be_valid
      expect(review.errors[:score]).to include("can't be blank")
    end

    it "is valid without a comment" do
      review.comment = nil
      expect(review).to be_valid
    end

    it "is invalid with a score outside the range 0-10" do
      review.score = 11
      expect(review).not_to be_valid
      expect(review.errors[:score]).to include("must be less than or equal to 10")

      review.score = -1
      expect(review).not_to be_valid
      expect(review.errors[:score]).to include("must be greater than or equal to 0")
    end
  end

  context "associations" do
    it "belongs to a user" do
      expect(review.user).to eq(user)
    end

    it "belongs to a movie" do
      expect(review.movie).to eq(movie)
    end
  end

  context "methods" do
    # Add any custom methods you want to test here, if applicable
    # Example:
    # describe "#method_name" do
    #   it "does something" do
    #     expect(review.method_name).to eq(expected_result)
    #   end
    # end
  end
end
