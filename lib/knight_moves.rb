require_relative "board"

class Knight
    attr_accessor :board, :moves, :starting_pos, :ending_pos

    def initialize(board, starting_pos, ending_pos)
        @board = board
        @starting_pos = starting_pos
        @ending_pos = ending_pos
        # p board
        # p starting_pos
        # p ending_pos
        # p starting_pos.zip(ending_pos).map { |x, y| y - x }
        @moves = possible_moves(@board, @starting_pos, @ending_pos)
    end

    def possible_moves(board, node = starting_pos, ending_pos)
        return if node.nil?

        queue = []
        res = []
        queue << node

        # current = queue.shift
        # res << current
        # board.each do |i|
        #     i.each do |j|
        #         if (j[0] - current[0]).abs == 1 && (j[1] - current[1]).abs == 2 && j != current
        #             queue << j
        #         elsif (j[0] - current[0]).abs == 2 && (j[1] - current[1]).abs == 1 && j != current
        #             queue << j
        #         end
        #     end
        # end

        until queue.any?(ending_pos)
            p queue
            p starting_pos
            p ending_pos

            current = queue.shift
            res << current
            board.each do |i|
                i.each do |j|
                    if (j[0] - current[0]).abs == 1 && (j[1] - current[1]).abs == 2 && j != current
                        queue << j
                    elsif (j[0] - current[0]).abs == 2 && (j[1] - current[1]).abs == 1 && j != current
                        queue << j
                    end
                end
            end
        end
        # p queue
        # p res
        queue
    end

    @moves
end
