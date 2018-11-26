require "./lib/player"

class AI < Player
  attr_reader :token
  attr_accessor :game, :skill

  def initialize(token)
    super
  end
end
