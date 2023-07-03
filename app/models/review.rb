class Review < ApplicationRecord
  validates :body, length: { minimum: 10,too_short: "must have at least %{count} characters.", }
  belongs_to :movie
  belongs_to :user
end
