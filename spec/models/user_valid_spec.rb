require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { 
         described_class.new(email: "rspec@test.ru",
                             password: "Mm12345678",
                             wins: 20,
                             looses: 5,
                             draws: 2
         )  
  }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a too short password" do
      subject.password = "1234"
      expect(subject).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

end