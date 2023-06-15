class Review < ApplicationRecord
  belongs_to :movie
  has_one :user, through: :movie
end
