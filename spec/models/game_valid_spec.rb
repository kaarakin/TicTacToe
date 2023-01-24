require 'rails_helper'

RSpec.describe Game, :type => :model do

  subject {
    described_class.new(state: {
      0 => { 0 => nil, 1 => nil, 2 => nil },
      1 => { 0 => nil, 1 => nil, 2 => nil },
      2 => { 0 => nil, 1 => nil, 2 => nil },
    }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a state" do
    subject.state = nil
    expect(subject).to be_valid
  end

  it "is not valid without a filled" do
    subject.filled = nil
    expect(subject).to be_valid
  end

  it "is not valid without a current_symbol" do
    subject.current_symbol = nil
    expect(subject).to be_valid
  end
end