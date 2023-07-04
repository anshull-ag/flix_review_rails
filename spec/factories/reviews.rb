FactoryBot.define do
  factory :review do
    body { "this is demo body" }
    star { 5 }
    association :movie
    association :user, factory: :user
  end
end
