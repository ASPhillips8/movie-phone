FactoryBot.define do
  factory :review do
    score { 8 }
    comment  { "Amazing movie!" }
    association :user
    association :movie
  end
end
