class GamesController < ApplicationController

  def show
    @game = Game.find(params[:game_id])
    @game.title = @game.title.titleize
    @game.release_date = @game.release_date[0..9]
    @game.log_line = @game.log_line[0..50] + "..."
    render json: {game: @game}
  end

  def game_query
    if Game.first.nil?
      GiantBombsConnection.new 
    end
    @query = params["title"].downcase.split(" ")
    @console = params["console"]
    @full_list = Game.game_finder(@console, @query)
    render json: {games: @full_list}
  end

end