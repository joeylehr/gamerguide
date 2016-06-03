class GamesController < ApplicationController

  def database
    $games = GiantBombsConnection.new
    query = params["title"].downcase.split(" ")
    console = params["console"]
    @full_list = $games.game_finder(console, query)
    render json: {games: @full_list}
  end

  def show
    games = $games
    @games = games.all_games
    @chosen_game = []
    @games.each do |game|
      if game[:game_bomber_id] == (params["game_id"].to_i)
        @chosen_game << game
      end
    end
    @title = @chosen_game[0][:title].titleize
    @log_line = @chosen_game[0][:log_line][0..50] + "..."
    @release_date = @chosen_game[0][:release_date][0..9]
    render json: {game: @chosen_game, title: @title, log_line: @log_line, release_date: @release_date}
  end

  def game_query
    query = params["title"].downcase.split(" ")
    console = params["console"]
    @full_list = $games.game_finder(console, query)
    render json: {games: @full_list}
  end

# HELPER METHODS

  # def find_games(params)

  # end

end

