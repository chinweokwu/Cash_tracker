require 'rails_helper'

RSpec.describe "transactions/show", type: :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      name: "Name",
      amount: "Amount",
      user: nil,
      group: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Amount/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end