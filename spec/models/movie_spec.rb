require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:reviews) }
    it { should belong_to(:category) }
    it { should have_one_attached(:main_image) }
  end

  describe "factories" do
    it "has a valid factory" do
      movie = FactoryBot.build(:movie)
      expect(movie).to be_valid
    end
  end
end
