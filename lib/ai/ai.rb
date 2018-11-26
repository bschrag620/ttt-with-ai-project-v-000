require "./lib/player"

class AI < Player
  attr_reader :token
  attr_accessor :board, :skill, :game

  def initialize(token, game)
    super

    # would like to add the ability to load different game logics depending on user choice

  end
end
