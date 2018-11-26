require_relative "scenario.rb"

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
        self.scenarios << Scenario.new(position)
      end
    end

    def test_position(position, board)
      test_board = Board.new
      test_board.cells = board.cells
      test_board.cells[position] = self.token
    end
    

    def move(board)
      valid_moves = valid_moves(board)
      create_scenario(valid_moves)
      self.scenarios.each do |scenario|
        scenario.score += test_move(scenario.position, board)
      end
    end
  end
end
