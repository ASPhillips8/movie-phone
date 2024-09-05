require 'rails_helper'

RSpec.describe "Movie search and filter" do
  let!(:user) { create(:user, age: 10) }

  let!(:genre_comedy) { create(:genre, name: "Comedy") }
  let!(:genre_animation) { create(:genre, name: "Animation") }

  let!(:movie_1) { create(:movie, title: "Funny Animation", rating: "PG", genres: [genre_animation]) }
  let!(:movie_2) { create(:movie, title: "Comedy Adventure", rating: "PG", genres: [genre_comedy]) }
  let!(:movie_3) { create(:movie, title: "Laugh Out Loud", rating: "PG-13", genres: [genre_comedy]) }
  let!(:movie_4) { create(:movie, title: "Scary Horror", rating: "R") }
  let!(:movie_5) { create(:movie, title: "Action Thriller", rating: "R") }
  let!(:movie_6) { create(:movie, title: "Comedy Animation", rating: "PG", genres: [genre_animation]) }

  before do
    visit signin_path
    fill_in "user_name", with: user.user_name
    fill_in "password", with: user.password
    click_button "Sign In"
    visit movies_path
  end

  describe "Age-appropriate movie display" do
    it "shows only movies suitable for user's age" do
      expect(page).to have_content("Funny Animation")
      expect(page).to have_content("Comedy Adventure")
      expect(page).to have_content("Comedy Animation")
      expect(page).not_to have_content("Laugh Out Loud")
      expect(page).not_to have_content("Scary Horror")
      expect(page).not_to have_content("Action Thriller")
    end
  end

  describe "Movie search" do
    context "when filtering by title" do
      it "displays matching movies" do
        fill_in "Search by title", with: "Comedy"
        click_button "Search"

        expect(page).to have_content("Comedy Adventure")
        expect(page).to have_content("Comedy Animation")
        expect(page).not_to have_content("Funny Animation")
      end
    end

    context "when filtering by genre" do
      it "displays movies from the selected genre" do
        select "Animation", from: "genre"
        click_button "Search"

        expect(page).to have_content("Funny Animation")
        expect(page).to have_content("Comedy Animation")
        expect(page).not_to have_content("Comedy Adventure")
      end
    end

    context "when filtering by both title and genre" do
      it "displays movies that match both criteria" do
        fill_in "Search by title", with: "Comedy"
        select "Animation", from: "genre"
        click_button "Search"

        expect(page).to have_content("Comedy Animation")
        expect(page).not_to have_content("Funny Animation")
        expect(page).not_to have_content("Comedy Adventure")
      end
    end
  end
end
