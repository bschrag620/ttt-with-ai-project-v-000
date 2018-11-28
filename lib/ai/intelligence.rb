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

    def move(board)
      original_cells = board.cells
      original_token = self.token
      valid_moves = valid_moves(board)
      valid_moves.each do |valid_move|
        
    end
  end
end
