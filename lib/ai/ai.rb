require "./lib/player"

class AI < Player
  attr_reader :token
  attr_accessor :game, :skill

  def initialize(token)
    super

    # would like to add the ability to load different game logics depending on user choice

  end
end
