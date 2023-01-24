# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'checking the contents in the db' do
    context 'gen_results' do
      it 'actual state' do
        expect(Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil).state).to eq ({
          "0" => { "0" => nil, "1" => nil, "2" => nil },
          "1" => { "0" => nil, "1" => nil, "2" => nil },
          "2" => { "0" => nil, "1" => nil, "2" => nil },
        })
      end
    end
    
    context 'current_symbol' do
      it 'should return x' do
        expect(Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil).current_symbol).to eq 'x'
      end
    end

    context 'filled' do
      it 'should return 0' do
        expect(Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil).filled).to eq 0
      end
    end

    context 'win_sym' do
      it 'should return nil' do
        expect(Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil).win_sym).to eq nil
      end
    end

    context 'user_id' do
      it 'should return nil' do
        expect(Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil).user_id).to eq nil
      end
    end
  end

  describe 'checking the update in the db' do
    context 'new gen_results' do
      it 'should return new state' do
        game = Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
        game.update_attribute(:state, {
          0 => { 0 => 'x', 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => 'x', 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => 'x' },
        })
        expect(game.state).to eq ({
          "0" => { "0" => 'x', "1" => nil, "2" => nil },
          "1" => { "0" => nil, "1" => 'x', "2" => nil },
          "2" => { "0" => nil, "1" => nil, "2" => 'x' },
        })
      end

      it 'should return new current_symbol' do
        game = Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
        game.update_attribute(:current_symbol, 'o')
        expect(game.current_symbol).to eq 'o'
      end

      it 'should return new filled' do
        game = Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
        game.update_attribute(:filled, 5)
        expect(game.filled).to eq 5
      end

      it 'should return new win_sym' do
        game = Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
        game.update_attribute(:win_sym, 'x')
        expect(game.win_sym).to eq 'x'
      end

      it 'should return new user_id' do
        game = Game.new(state: {
          0 => { 0 => nil, 1 => nil, 2 => nil },
          1 => { 0 => nil, 1 => nil, 2 => nil },
          2 => { 0 => nil, 1 => nil, 2 => nil },
        }, current_symbol: 'x', filled: 0, win_sym: nil, user_id: nil)
        game.update_attribute(:user_id, 333)
        expect(game.user_id).to eq "333"
      end
    end
  end
end
