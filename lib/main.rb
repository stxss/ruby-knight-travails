require_relative "board"
require_relative "knight_moves"

def knight_moves(starting, ending)
  chess_board = Board.new

  knight = Knight.new(chess_board.board, starting, ending)
  path = knight.moves
  if path.length < 2
    puts "You made it in #{path.length - 1} move! Here's your path:"
  else
    puts "You made it in #{path.length - 1} moves! Here's your path:"
  end
  path.each do |i|
    puts "[#{i.first},#{i.last}]"
  end
end

knight_moves([0, 0], [1, 2])
knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
knight_moves([3, 3], [4, 3])
knight_moves([0, 1], [6, 2])
knight_moves([3, 2], [3, 7])
knight_moves([0, 0], [7, 7])
