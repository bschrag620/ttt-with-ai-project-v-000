require "./lib/player"

class AI < Player
  attr_reader :token
  attr_accessor :game, :skill

  def initialize(token)
    super
    puts "What skill level for player #{@token}?"
    puts "1) easy"
    puts "2) unbeatable"
    user_input =nil
    if user_input != "1" || user_input != "2"
      user_input = gets.strip
    end
    @skill = user_input.to_i
    puts "skill set to #{@skill}"
  end
end
