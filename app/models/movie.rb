class Movie < ApplicationRecord
  validates :name, presence: true
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_one_attached :main_image
end
