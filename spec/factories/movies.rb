FactoryBot.define do
  factory :movie do
    name { "Example Movie" }
    rating { 4.5 }
    description { "An amazing movie" }
    released_date { Date.today }
    star_cast { "John Doe, Jane Smith" }
    association :category

    after(:build) do |movie|
      movie.reviews << build_list(:review, 3, movie: movie)
    end

    trait :with_reviews do
      after(:create) do |movie|
        create_list(:review, 5, movie: movie)
      end
    end
  end
end

