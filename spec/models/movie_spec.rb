require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { create(:movie) }

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

      review1 = create(:review, movie: movie, user: create(:user, user_name: "user1"))
      review2 = create(:review, movie: movie, user: create(:user, user_name: "user2"))

      expect(movie.reviews).to include(review1, review2)
    end

    it 'can have many users through reviews' do

      user1 = create(:user, user_name: "user1")
      user2 = create(:user, user_name: "user2")
      create(:review, movie: movie, user: user1)
      create(:review, movie: movie, user: user2)

      expect(movie.users).to include(user1, user2)
    end

    it 'can have many genres' do

      genre1 = Genre.create(name: 'Animation')
      genre2 = Genre.create(name: 'Family')
      movie.genres << [genre1, genre2]

      expect(movie.genres).to include(genre1, genre2)
    end
  end

  context "methods" do
    describe "#average_score" do
      it "calculates the average score of the movie" do
        create(:review, score: 5, movie: movie, user: create(:user, user_name: "user1"))
        create(:review, score: 3, movie: movie, user: create(:user, user_name: "user2"))

        expect(movie.average_score).to eq(4.0)
      end
    end

    describe "#formatted_release_date" do
      it "returns the release date in the format 'November 22, 1995'" do
        movie.update(release_date: "1995-11-22")
        expect(movie.formatted_release_date).to eq("November 22, 1995")
      end
    end
  end

  context "scopes" do
    describe ".highest_rated_unreviewed_by" do
      let(:user) { create(:user, user_name: "unique_user1") }
      let(:user2) { create(:user, user_name: "unique_user2") }
      let(:user3) { create(:user, user_name: "unique_user3") }

      it "returns the highest-rated movies that the user hasn't reviewed" do
        reviewed_movie1 = create(:movie)
        reviewed_movie2 = create(:movie)

        create(:review, score: 5, movie: reviewed_movie1, user: user2)
        create(:review, score: 6, movie: reviewed_movie2, user: user2)
        create(:review, score: 4, movie: movie, user: user2)

        create(:review, score: 6, movie: reviewed_movie1, user: user)

        result = Movie.highest_rated_unreviewed_by(user)

        expect(result).to include(reviewed_movie2)
        expect(result).not_to include(reviewed_movie1)
      end
    end

    describe ".unreviewed_movie_of_favorite_genre" do
      let(:user) { create(:user, favorite_genre: "Action", user_name: "unique_user1") }
      let(:other_genre) { create(:genre, name: "Drama") }
      let(:favorite_genre) { create(:genre, name: "Action") }

      let!(:movie1) { create(:movie, title: "Action Movie 1") }
      let!(:movie2) { create(:movie, title: "Action Movie 2") }
      let!(:drama_movie) { create(:movie, title: "Drama Movie") }

      before do
        movie1.genres << favorite_genre
        movie2.genres << favorite_genre
        drama_movie.genres << other_genre

        create(:review, score: 5, movie: movie1, user: user)
      end
      it "returns the a movie of users favorite genre that they have not reviewed" do
        result = Movie.unreviewed_movie_of_favorite_genre(user)
        expect(result).to include(movie2)
        expect(result).not_to include(movie1)
        expect(result).not_to include(drama_movie)
      end
    end
  end
end
