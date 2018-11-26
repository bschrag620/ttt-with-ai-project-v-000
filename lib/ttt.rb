require_relative "board"
require_relative "game"
require_relative "players/human"
require_relative "players/computer"

puts "Welcome to Tic Tac Toe"
user_input = nil
while user_input != "exit"
  play = false
  puts "How many players (type exit to quit)? "
  user_input = gets.strip
  case user_input
  when "0" 
    game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"))
    play = true
  when "1"
    game = Game.new(Players::Human.new("X"), Players::Computer.new("O"))
    play = true
  when "2"
    game = Game.new(Players::Human.new("X"), Players::Human.new("O"))
    play =true
  when "exit"
    play = false
  else
    puts "Invalid input.Please try again."
  end
  if play
    game.play
  end
end
