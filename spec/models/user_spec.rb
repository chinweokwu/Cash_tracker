require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validation Tests for Users' do
    let(:user) { User.new(name: 'user_test', email: 'name@example.com') }

    it 'Should not be valid if email is empty' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'Should be valid with a email of correct format' do
      user.email = 'name@example.com'
      expect(user).to be_valid
    end
  end

  describe 'Associations to user model' do
    it { should have_many(:groups) }
    it { should have_many(:transactions) }
  end
end
