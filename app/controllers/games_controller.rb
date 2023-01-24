class GamesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:welcome]

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    if current_user
      @user_id = current_user.id
      @game.set_user_id(@user_id)
    end
  end

  def create
    redirect_to Game.create
  end

  def welcome
  end

  def leaderboard
    @users = User.all
    @users.each do |user|
      User.find_by(id: user.id).update_column(:wins, Game.where(user_id: user.id).where(win_sym: 'x').count)
      User.find_by(id: user.id).update_column(:looses, Game.where(user_id: user.id).where(win_sym: 'o').count)
      User.find_by(id: user.id).update_column(:draws, Game.where(user_id: user.id).where(win_sym: 'draw').count)
      count = User.find_by(id: user.id).wins + User.find_by(id: user.id).looses + User.find_by(id: user.id).draws
      User.find_by(id: user.id).update_column(:success, (User.find_by(id: user.id).wins.to_f / count.to_f).round(2)) if !count.zero?
    end
  end
end
