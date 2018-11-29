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
      locations = Array (1..9)
      locations.each do |location|
        if board.valid_move?(location.to_i)
          valid_moves << location.to_s
        end
      end
      valid_moves
    end

    def move(board)
      board.cells = ["X", " ", " ", "O", "X", " ", " ", " ", " "]
      all_moves = valid_moves(board)
      all_moves.each {|i| puts i}
    end


  end
end
