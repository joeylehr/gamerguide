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

  def initialize
    platforms = {"21": "NES", "43": "N64", "9": "SNES"}
    @offset = 100
    all_games_per_console(platforms)
  end

  def all_games_per_console(platforms)
    platforms.each do |platform_id, platform_name|     
      while offset < console_games(platform_id)["number_of_total_results"]
        games = console_games(platform_id)  
        game_creator(games, platforms, platform_id)
        @offset += 100
      end
      @offset = 100
    end
  end

  def api_key
    "a96b654aa317c1b5a10343a84aa1ea380ba3ffe5"
  end

  def base_path
    "/games/?api_key=#{api_key}&format=json&offset=#{offset}"
  end

  def console_games(platform_id)
    puts "GETTING FROM #{base_path}&platforms=#{platform_id}"
    url = "#{base_path}&platforms=#{platform_id}"
    self.class.get(url)
  end

  def game_creator(games, platforms, platform_id)
    games["results"].each do |game|
      if game["image"].present?
        Game.find_or_create_by(:title => game["name"].downcase, :image => game["image"].fetch("thumb_url"), :alias => game["aliases"], :release_date => (game["original_release_date"]), :link => game["site_detail_url"], :console => platforms[platform_id.to_sym], :log_line => game["deck"], :game_bomber_id => (game["id"]))
      else 
        Game.find_or_create_by(:title => game["name"].downcase, :console => platforms[platform_id.to_sym], :game_bomber_id => (game["id"]))
      end    
    end
  end

end
