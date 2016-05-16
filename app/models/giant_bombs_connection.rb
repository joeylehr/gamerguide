# == Schema Information
#
# Table name: giant_bombs_connections
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GiantBombsConnection
  include HTTParty
  base_uri 'http://www.giantbomb.com/api'
  attr_reader :offset
  attr_accessor :status, :all_games


def initialize
  platforms = {"21": "NES", "43": "N64", "9": "SNES"}
  # platforms = {"43": "N64"}
  @offset = 100
  @all_games = all_games_per_console(platforms)
  end


  def game_finder(console, query)
    if console != "ALL"
      keywords = query.length.to_s
      case keywords
      when "1"
      @all_games.find_all { |game| (game[:console] == console) && game[:title].include?("#{query[0]}") }
      when "2"
      @all_games.find_all { |game| (game[:console] == console) && game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}")}
      when "3"
      binding.pry
      @all_games.find_all { |game| (game[:console] == console) && game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}") && game[:title].include?("#{query[2]}")}  
      when "4"
      @all_games.find_all { |game| (game[:console] == console) && game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}") && game[:title].include?("#{query[2]}") && game[:title].include?("#{query[3]}")}        
      end
    else 
      keywords = query.length.to_s
      case keywords
      when "1"
      @all_games.find_all { |game| game[:title].include?("#{query[0]}") }
      when "2"
      @all_games.find_all { |game| game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}")}
      when "3"
      @all_games.find_all { |game| game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}") && game[:title].include?("#{query[2]}")}  
      when "4"
      @all_games.find_all { |game| game[:title].include?("#{query[0]}") && game[:title].include?("#{query[1]}") && game[:title].include?("#{query[2]}") && game[:title].include?("#{query[3]}")}        
      end
    end    
  end

  def games_hash
    @games_hash
  end


def all_games_per_console(platforms)
  all_games = []
  n64_games = []
  nes_games = []
  snes_games = []
  platforms.each do |platform_id, platform_name|     
    while offset < console_games(platform_id)["number_of_total_results"]
      games = console_games(platform_id)  
      game = game_creator(games, platforms, platform_id)
      if game.first.fetch(:console) == "N64"
        n64_games << game.flatten
      elsif game.first.fetch(:console) == "NES"
        nes_games << game.flatten
      elsif game.first.fetch(:console) == "SNES"
        snes_games << game.flatten
      end  
      @offset += 100
    end
    @offset = 100
  end
  all_games << n64_games.flatten
  all_games << nes_games.flatten
  all_games << snes_games.flatten
  all_games.flatten.compact
end

  def base_path
    api_key = ENV["API_KEY"]
    "/games/?api_key=#{api_key}&format=json&offset=#{offset}"
  end


  def console_games(platform_id)
    puts "GETTING FROM #{base_path}&platforms=#{platform_id}"
    url = "#{base_path}&platforms=#{platform_id}"
    self.class.get(url)
  end

def game_creator(games, platforms, platform_id)
    games["results"].map do |game|
    if (game["image"].present? && platform_id.to_s == "43")
      {:title => game.fetch("name").downcase, :image => game["image"].fetch("thumb_url"), :alias => game["aliases"], :console => platforms[platform_id.to_sym], :release_date => (game["original_release_date"]), :link => game["site_detail_url"], :log_line => game["deck"], :game_bomber_id => (game["id"])}
    elsif (game["image"].present? && platform_id.to_s == "21")
      {:title => game.fetch("name").downcase, :image => game["image"].fetch("thumb_url"), :alias => game["aliases"], :console => platforms[platform_id.to_sym], :release_date => (game["original_release_date"]), :link => game["site_detail_url"], :log_line => game["deck"], :game_bomber_id => (game["id"])}
    elsif (game["image"].present? && platform_id.to_s == "9")
      {:title => game.fetch("name").downcase, :image => game["image"].fetch("thumb_url"), :alias => game["aliases"], :console => platforms[platform_id.to_sym], :release_date => (game["original_release_date"]), :link => game["site_detail_url"], :log_line => game["deck"], :game_bomber_id => (game["id"])}
    end
  end
end


end


#     def self.game_finder(console, query)
#     @all_games = @games.all_games
#     @all_64_games = @games.n64_games
#     @all_nes_games = @games.nes_games
#     @all_snes_games = @games.snes_games
#     first_sql = []
#     i = 0 
#     if console == "ALL" 
#       while i < query.length
#         first_sql << "title LIKE '%#{query[i]}%' AND" 
#         i += 1
#       end
#     else
#       first_sql << "console = '#{console}' AND"
#       while i < query.length
#       first_sql << "title LIKE '%#{query[i]}%' AND"
#       i += 1
#       end 
#     end
#     if !first_sql.to_s.include?("console =")
#     if query.length > 1
#       likes = first_sql.join(", ")[0..-5].gsub!(/,/, "")
#     else 
#       likes = first_sql.join(", ")[0..-5]
#     end
#     else
#       likes = first_sql.join(", ")[0..-5].gsub!(/,/, "")
#     end
#     self.where(likes)
# end
# end