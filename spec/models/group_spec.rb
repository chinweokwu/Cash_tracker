require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user_account) { User.create!(name: 'pman', email: 'pman@example.com') }
  let(:create_group) { user_account.groups.create!(name: 'gym', icon: ' <i class="fas fa-cash-register" aria-hidden="true"></i>') }

  it 'is valid with all attributes present' do
    expect(create_group).to be_valid
  end

  it 'is not valid without a name' do
    create_group.name = nil
    expect(create_group).to_not be_valid
  end

  it 'is not valid without a selected icon' do
    create_group.icon = nil
    expect(create_group).to_not be_valid
  end

  describe 'Associations' do
    context 'should belong to transaction model' do
      it { should have_many(:transactions) }
    end

    context 'should belong to a user model' do
      it { should belong_to(:user) }
    end
  end
end
