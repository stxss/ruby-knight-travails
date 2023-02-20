require_relative "board"
require_relative "knight_moves"

chess_board = Board.new

chess_board.board.each do |i|
    p i
end
