class Board
  attr_accessor :board
  def initialize
    @board = create_board
  end

  def create_board
    arr = Array.new(8) { Array.new(8) }
    8.times do |row|
      8.times do |column|
        arr[row][column] = [row, column]
      end
    end
    arr
  end
end
