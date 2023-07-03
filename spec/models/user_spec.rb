require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:reviews) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'callbacks' do
    describe '#set_defaults' do
      it 'sets the role to :user if not present' do
        user = FactoryBot.build(:user, role: nil)
        user.send(:set_defaults) # explicitly call the set_defaults method
        expect(user.role).to eq('user')
      end

      it 'does not change the role if already set' do
        user = FactoryBot.build(:user, role: :admin)
        user.send(:set_defaults) # explicitly call the set_defaults method
        expect(user.role).to eq('admin')
      end
    end

    describe '#welcome_email' do
      it 'sends a confirmation email after creating a user' do
        user = FactoryBot.build(:user)
        expect { user.save }.to change { ActionMailer::Base.deliveries.count }.by(1)
        mail = ActionMailer::Base.deliveries.last
        expect(mail.subject).to eq('Confirmation Email')
        expect(mail.to).to eq([user.email])
      end
    end
  end
end
