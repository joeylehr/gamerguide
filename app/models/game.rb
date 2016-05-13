# == Schema Information
#
# Table name: games
#
#  id             :integer          not null, primary key
#  title          :string
#  release_date   :string
#  alias          :string
#  image          :string
#  link           :string
#  console        :string
#  log_line       :string
#  game_bomber_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Game < ActiveRecord::Base


    def self.game_finder(console, query)
    @all_games = @games.all_games
    @all_64_games = @games.n64_games
    @all_nes_games = @games.nes_games
    @all_snes_games = @games.snes_games
    first_sql = []
    i = 0 
    if console == "ALL" 
      while i < query.length
        first_sql << "title LIKE '%#{query[i]}%' AND" 
        i += 1
      end
    else
      first_sql << "console = '#{console}' AND"
      while i < query.length
      first_sql << "title LIKE '%#{query[i]}%' AND"
      i += 1
      end 
    end
    if !first_sql.to_s.include?("console =")
    if query.length > 1
      likes = first_sql.join(", ")[0..-5].gsub!(/,/, "")
    else 
      likes = first_sql.join(", ")[0..-5]
    end
    else
      likes = first_sql.join(", ")[0..-5].gsub!(/,/, "")
    end
    self.where(likes)
end
end




#     def self.game_finder(console, query)
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
