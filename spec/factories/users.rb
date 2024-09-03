FactoryBot.define do
  factory :user do
    first_name { "Anthony" }
    last_name { "Lumpenstein" }
    age { 35 }
    favorite_genre { "Horror" }
    user_name { "Lumpy3" }
    password { "password1" }
    password_confirmation { "password1" }
  end
end
