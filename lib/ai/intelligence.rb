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

    def create_scenario(valid_moves)
      valid_moves.each do |position|
        self.class.scenarios << Scenario.new(position)
      end
    end

    def test_position(position, board)
      old_positions = board.cells
      board.cells[position.to_i] = self.token
      if self.class.game.won?
        10
      elsif self.class.game.draw?
        0
      else
        if self.class..token == "X"
          new_token = "O"
        else
          new_token = "X"
        end
        new_score = 0
        new_player = Players::Computer.new(new_token)
        new_valid_moves = valid_moves(test_board)
        new_valid_moves.each do |new_move|
          new_score -= (new_player.test_position(new_move, test_board))
        end
        new_score
      end
    end

    def return_best_choice(array)
      initial_score = 0
      choices = []
      array.each do |scenario|
        if scenario.score > initial_score
          initial_score = scenario.score
          choices = []
          choices << scenario
        elsif scenario.score == initial_score
          choices << scenario
        end
      end
      choices
    end

    def move(board)
      valid_moves = valid_moves(board)
      create_scenario(valid_moves)
      self.class.scenarios.each do |scenario|
        scenario.score += test_position(scenario.position, board)
      end
      return_best_choice(self.class.scenarios).sample
    end
  end
end
