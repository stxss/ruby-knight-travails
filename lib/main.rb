require_relative "board"
require_relative "knight_moves"

def knight_moves(starting, ending)
    chess_board = Board.new

    knight =  Knight.new(chess_board.board, starting, ending)

end

# knight_moves([0, 0], [1, 2])
# knight_moves([0, 0], [3, 3])
knight_moves([3, 3], [0, 0])
# knight_moves([3, 3], [4, 3])
