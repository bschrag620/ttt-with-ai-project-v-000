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
      valid_moves.collect do |v_m|
        Scenario.new(v_m)
      end
    end

    def execute_scenario(scenario, board)
      result = self.test_move(scenario.position, board)
    end

    def test_move(position, board)
      original_cells = board.cells
      board.cells[position.to_i - 1] = self.token
      result = self.game.over?
      board.cells = original_cells
      result
    end

    def move(board)
      scenarios = self.create_scenarios(valid_moves(board))
      original_cells = board.cells
      original_token = self.token
      scenarios.each do |scenario|
        if self.execute_scenario(scenario, board)
          puts "scenario won or draw"
          gets
        else
          puts "no win or draw, change token and check next set of moves"
          board.cells[scenario.position.to_i - 1] = self.token
          board.display
          gets
          self.token = swap_token
          self.move(board)
        end
        puts "done testing scenario #{scenario.position}, resetting values"
        gets
        board.cells = original_cells
        self.token = original_token
      end
    end
  end
end
