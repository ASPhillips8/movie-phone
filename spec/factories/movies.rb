FactoryBot.define do
  factory :movie do
    title { "Matrix" }
    description  { "blah blah blah" }
    run_time { 70 }
    rating { "R" }
    release_date { Date.new(2003, 8, 1) }
  end
end
