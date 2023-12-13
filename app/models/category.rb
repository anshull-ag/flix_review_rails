class Category < ApplicationRecord
  has_many :movies, dependent: :destroy
  validates :name, presence: true
end
