class GamesController < ApplicationController

  def database
    @@games = GiantBombsConnection.new
    query = params["title"].downcase.split(" ")
    console = params["console"]
    @full_list = @@games.game_finder(console, query)
    render json: {games: @full_list}
  end

  def show
    binding.pry
    @@games
    @game.title = @game.title.titleize
    @game.release_date = @game.release_date[0..9]
    @game.log_line = @game.log_line[0..50] + "..."
    binding.pry
    render json: {game: @game}
  end

  def game_query
    query = params["title"].downcase.split(" ")
    console = params["console"]
    @full_list = @@games.game_finder(console, query)
    # @full_list = Game.game_finder(@console, @query)
    render json: {games: @full_list}
  end

end

