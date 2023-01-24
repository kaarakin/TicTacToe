class MovesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    @game.move!(params[:row], params[:col])

    if @game.filled < 9 && !@game.game_over?
      sleep rand(0.1..0.6)
      @game.ai_move!
    end

    respond_to do |format|
      format.turbo_stream
      format.html {
        redirect_to @game
      }
    end
  end
end
