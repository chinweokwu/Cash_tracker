require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:user_account) { User.create!(name: 'pman', email: 'pman@example.com') }
  let(:create_group) { user_account.groups.create!(name: 'gym', icon: ' <i class="fas fa-cash-register" aria-hidden="true"></i>') }
  let(:transaction_account) { Transaction.create!(name: 'food', amount: 100, user_id: user_account.id, group_id: create_group.id) }

  it 'is valid with all attributes present' do
    expect(transaction_account).to be_valid
  end

  it 'is not valid without a name' do
    transaction_account.name = nil
    expect(transaction_account).to_not be_valid
  end

  it 'is not valid without an amount' do
    transaction_account.amount = nil
    expect(transaction_account).to_not be_valid
  end

  it 'is valid without any group selected' do
    transaction_account.group_id = nil
    expect(transaction_account).to be_valid
  end

  describe 'Associations' do
    context 'should belong to a user model' do
      it { should belong_to(:user) }
    end
  end
end
