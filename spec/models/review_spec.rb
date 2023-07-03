require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { should validate_length_of(:body).is_at_least(10).with_message('must have at least 10 characters.') }
  end

  describe 'associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:user) }
  end
end
