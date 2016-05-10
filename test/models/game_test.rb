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

require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
