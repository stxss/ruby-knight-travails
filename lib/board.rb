class Board
    attr_accessor :board
    def initialize
        @board = create_board
        # @board = Array.new(8, Array.new(8, (0..2).to_a))
    end

    def create_board
        arr = Array.new(8) {Array.new(8)}
        8.times do |row|
            8.times do |column|
                arr[row][column] = [row, column]
            end
        end
        arr
    end
end

