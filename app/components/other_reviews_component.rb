# frozen_string_literal: true

class OtherReviewsComponent < ViewComponent::Base
  def initialize(reviews:, movie:)
    @reviews = reviews
    @movie = movie
  end

end
