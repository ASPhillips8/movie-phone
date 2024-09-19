# frozen_string_literal: true

require "rails_helper"

RSpec.describe OtherReviewsComponent, type: :component do
  let(:movie) { create(:movie) }
  let(:user1) { create(:user, user_name: "UserOne") }
  let(:user2) { create(:user, user_name: "UserTwo") }
  let!(:review1) { create(:review, movie: movie, user: user1, score: 5, comment: "Amazing movie!") }
  let!(:review2) { create(:review, movie: movie, user: user2, score: 4, comment: "Great, but complex.") }
  let(:other_reviews) { [review1, review2] }

  it "renders the average review score of movie" do
    render_inline(OtherReviewsComponent.new(reviews: other_reviews, movie: movie))

    expect(page).to have_text("Users rating: 4.5")
  end

  it "renders a list of reviews by users with score given by user" do
    render_inline(OtherReviewsComponent.new(reviews: other_reviews, movie: movie))

    expect(page).to have_text("5")
    expect(page).to have_text("4")
    expect(page).to have_text("Amazing movie!")
    expect(page).to have_text("Great, but complex.")
  end
end
