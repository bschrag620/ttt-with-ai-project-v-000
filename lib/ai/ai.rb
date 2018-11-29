require "./lib/player"

class AI < Player
  attr_accessor :token
  attr_accessor :skill, :game

  def initialize(token, game)
    super
    puts "game initialzied to: #{game}"
    # would like to add the ability to load different game logics depending on user choice

  end
end
