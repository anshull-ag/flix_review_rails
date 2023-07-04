FactoryBot.define do
  factory :user do
    name {"anshul"}
    sequence(:email) { |n| "movie#{n}@example.com" }
    password {"12345678"}
    role { :user }
  end
end