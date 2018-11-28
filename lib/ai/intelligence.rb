require_relative "scenario.rb"
require "./lib/players/computer"

module Easymax
  module ClassMethods

  end

  module InstanceMethods
    def move(board)
      valid_moves = []
      (1..9).each do |i|
        if board.valid_move?(i)
          valid_moves << i.to_s
        end
      end
      puts "this was called from easymax"
      valid_moves.sample
    end
  end

end

module Minimax
  module ClassMethods

  end

  module InstanceMethods

    def valid_moves(board)
      valid_moves = []
      (1..9).each do |i|
        if board.valid_move?(i)
          valid_moves << i.to_s
        end
      end
      valid_moves
    end

    def swap_token
      if self.token == "X"
        "O"
      else
        "X"
      end
    end

    def create_scenarios(valid_moves)
      puts "valid moves: "
      valid_moves.collect do |valid_move|
        Scenario.new(valid_move)
      end
    end

    def test_moves(board, position)
      puts "player: #{self}"
      board.cells[position.to_i - 1] = self.token
      if game.won?
        score = 10
      elsif game.draw?
        score = 0
      else
        score = 0
        self.token = swap_token
        new_scenarios = create_scenarios(valid_moves(board))
        new_scenarios.each do |scenario|
          score -= self.test_moves(board, scenario.position)
        end
      end
      score
    end

    def move(board)
      original_cells = board.cells
      original_token = self.token
      valid_moves = valid_moves(board)
      scenarios = create_scenarios(valid_moves)
      scenarios.each do |scenario|
        puts "scenario: #{scenario}"
        scenario.score = test_moves(board, scenario.position)
      end
      scenarios.each do |scenario|
        puts "position: #{scenario.position}    score: #{scenario.score}"
      end
    end
  end
end
