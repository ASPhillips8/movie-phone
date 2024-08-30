require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(
      first_name: "Anthony",
      last_name: "Lumpenstein",
      age: 35,
      favorite_genre: "Horror",
      user_name: "Lumpy3",
      password: "password1",
      password_confirmation: "password1"
    )
  end

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
      User.create(
        first_name: "Another",
        last_name: "User",
        age: 25,
        favorite_genre: "Comedy",
        user_name: "Lumpy3",
        password: "password2",
        password_confirmation: "password2"
      )
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
  end
end


