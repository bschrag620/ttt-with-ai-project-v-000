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

    def process_scenarios
      last_scenario = self.scenarios.keys.max
      while self.scenarios[last_scenario][:parent] > 0
        self.scenarios.each do |scenario|
          puts scenario
        end
        gets
        parent = self.scenarios[last_scenario][:parent]
        self.scenarios[parent][:score] -= self.scenarios[last_scenario][:score]
        self.scenarios.delete(last_scenario)
        last_scenario = self.scenarios.keys.max
      end
    end

    def create_scenarios(board, parent)
      #get a list of possible moves
      possible_moves = valid_moves(board)

      # id list to track which hash id's are for this scenario
      id_list = []
      # populate a hash with id specific scenarios
      #puts self.scenarios.count
      possible_moves.each do |position|
        id = self.scenarios.count + 1
        id_list << id
        self.scenarios[id] = {position: position,
                              score: 0,
                              token: self.token,
                              parent: parent}
      end
      #check each scenario to see if it wins or ties
      id_list.each do |id|
        test_position = self.scenarios[id][:position]
        token = self.scenarios[id][:token]
        self.token = token
        self.scenarios[id][:before_move] = board.cells.dup
        #puts "scenario #{id}   test #{self.token} at position #{test_position} board: #{self.scenarios[id][:board]}"
        board.cells[test_position.to_i - 1] = self.token
        self.scenarios[id][:after_move] = board.cells.dup
        #board.display
        #gets
        if game.over?
          self.scenarios[id][:score] = score
          puts "game finish: #{score} on #{self.game.won?}"
          board.cells[test_position.to_i - 1] = " "
          return
          puts "board should be reset"
          board.display

        else
          self.token = other_token
          create_scenarios(board, id)
          board.cells[test_position.to_i - 1] = " "
        end

      end
    end

    def best_move(board)
      if board.turn_count == 0
        return ["1","3","7","9"].sample
      elsif
        board.turn_count == "1" and board.taken?("1") || board.taken?("3") || board.taken?("7") || board.taken("9")
      end
      puts "creating scenarios"
      create_scenarios(board, 0)
      puts "processing scenarios"
      process_scenarios
      hi_score = self.scenarios.max_by {|k,v| v[:score]}[1][:score]
      #puts "hi_score: #{hi_score}"
      #gets
      choices = []
      self.scenarios.select {|k,v| v[:score] == hi_score}.each do |scenario|
        puts "selected #{scenario}"
        gets
        choices << scenario[1][:position]
      end
      choice = choices.sample
      puts "choice: #{choice}"
      choice
    end



    def move(board)
      puts "pausing to see computer choice - press enter to continue"
      board.display
      gets
      self.scenarios = {}
      choice = best_move(board)
      choice
    end

  end
end
