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

    def score
      if self.game.won?
        return 10
      else
        return 0
      end
    end

    def other_token
      if self.token == "X"
        "O"
      else
        "X"
      end
    end

    def best_move(board, parent)
      #get a list of possible moves
      possible_moves = valid_moves(board)

      # id list to track which hash id's are for this scenario
      id_list = []
      # populate a hash with id specific scenarios
      possible_moves.each do |position|
        id = self.scenarios.count + 1
        id_list << id
        self.scenarios[id] = {position: position,
                              score: 0,
                              token: self.token,
                              parent: parent,
                              board: board.cells}
      end

      #check each scenario to see if it wins or ties
      id_list.each do |id|
        test_position = self.scenarios[id][:position]
        token = self.scenarios[id][:token]
        self.token = token
        #puts "scenario #{id}   test #{self.token} at position #{test_position}"
        board.cells[test_position.to_i - 1] = self.token
        #board.display
        #gets
        if game.over?
          self.scenarios[id][:score] = score
          #puts "game finish: #{score} on #{self.game.won?}"
          board.cells[test_position.to_i - 1] = " "
          #puts "board should be rest"
          #board.display
          #gets
        else
          self.token = other_token
          best_move(board, id)
          board.cells[test_position.to_i - 1] = " "
        end
        #self.scenarios.each do |key, value|
        #  puts "#{key} ==> #{value}"
        #end
      end
      self.scenarios.each do |key, value|
        puts "#{key} ==> #{value}"
      end
    end


    def move(board)
      self.scenarios = {}
      choice = best_move(board, 0)
      false
    end

  end
end
