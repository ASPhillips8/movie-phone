require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context "validations" do
    it "is valid with all attributes present" do
      expect(user).to be_valid
    end

    %i[first_name last_name age favorite_genre user_name password].each do |attr|
      it "is invalid without a #{attr.to_s.humanize.downcase}" do
        user.send("#{attr}=", nil)
        expect(user).not_to be_valid
        expect(user.errors[attr]).to include("can't be blank")
      end
    end

    it "is invalid with a duplicate user name" do
      create(:user, user_name: "Lumpy3")
      expect(user).not_to be_valid
      expect(user.errors[:user_name]).to include("has already been taken")
    end

    it "is invalid if password confirmation doesn't match" do
      user.password_confirmation = "different_password"

      expect(user).not_to be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
  end

  context "associations" do
    it "should have many reviews" do
      association = User.reflect_on_association(:reviews)

      expect(association.macro).to eq(:has_many)
    end

    it "should have many movies through reviews" do
      association = User.reflect_on_association(:movies)

      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:reviews)
    end
  end

  context "methods" do
    describe "#full_name" do
      it "returns the user's full name" do
        expect(user.full_name).to eq("Anthony Lumpenstein")
      end
    end

    describe "age_based_movies" do

      it "returns movies that are G and PG of ages 0-12" do
        user = build(:user, age: 10)
        g_movie = create(:movie, rating: "G")
        pg_movie = create(:movie, rating: "PG")
        pg13_movie = create(:movie, rating: "PG-13")
        r_movie = create(:movie, rating: "R")

        movie_age = user.age_based_movies

        expect(movie_age).to include(g_movie, pg_movie)
        expect(movie_age).not_to include(pg13_movie, r_movie)
      end

      it "returns movies that are G, PG, PG-13 for ages 13-16" do
        user = build(:user, age: 13)
        g_movie = create(:movie, rating: "G")
        pg_movie = create(:movie, rating: "PG")
        pg13_movie = create(:movie, rating: "PG-13")
        r_movie = create(:movie, rating: "R")

        movie_age = user.age_based_movies

        expect(movie_age).to include(g_movie, pg_movie, pg13_movie)
        expect(movie_age).not_to include(r_movie)

      end

      it "returns movies that are all rating for ages 17 and up" do
        user = build(:user, age: 18)
        g_movie = create(:movie, rating: "G")
        pg_movie = create(:movie, rating: "PG")
        pg13_movie = create(:movie, rating: "PG-13")
        r_movie = create(:movie, rating: "R")

        movie_age = user.age_based_movies

        expect(movie_age).to include(g_movie, pg13_movie, pg_movie, r_movie)
      end
    end
  end
end
