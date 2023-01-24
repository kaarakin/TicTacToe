# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'checking the contents in the db' do
    context 'email' do
      it 'should return correct email' do
        expect(User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1).email).to eq "test@model.ru"
      end
    end

    context 'password' do
      it 'should return 99' do
        expect(User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1).password).to eq "12345678"
      end
    end

    context 'wins' do
      it 'should return 99' do
        expect(User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1).wins).to eq 10
      end
    end

    context 'looses' do
      it 'should return 99' do
        expect(User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1).looses).to eq 3
      end
    end

    context 'draws' do
      it 'should return 99' do
        expect(User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1).draws).to eq 1
      end
    end
  end

  describe 'checking the update in the db' do
    context 'new statistics' do
      it 'should return new wins' do
        user = User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1)
        user.update_attribute(:wins, 100)
        expect(User.last.wins).to eq 100
      end

      it 'should return new looses' do
        user = User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1)
        user.update_attribute(:looses, 2)
        expect(User.last.looses).to eq 2
      end

      it 'should return new draws' do
        user = User.new(email: "test@model.ru", password: "12345678", wins: 10, looses: 3, draws: 1)
        user.update_attribute(:draws, 40)
        expect(User.last.draws).to eq 40
      end
    end
  end
end