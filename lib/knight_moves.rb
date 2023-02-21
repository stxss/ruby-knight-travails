require_relative "board"

class Knight
  attr_accessor :board, :moves, :starting_pos, :ending_pos

  MINIMUM_JUMPS_TO_VICINITY = 3
  MIN_JUMP_SIZE = 6
  MAX_JUMP_SIZE = 17
  MIN_TO_PREVENT_OVERLAP = 3

  def initialize(board, starting_pos, ending_pos)
    @board = board
    @starting_pos = starting_pos
    @ending_pos = ending_pos
    @moves = possible_moves(@board, @ending_pos, @starting_pos)
  end

  def possible_moves(board, ending_pos, node = starting_pos, visited = [], queue = [])
    return if node.nil?

    current = node
    visited << current

    # To get all the possible children and not going out of the board bounds
    board.each do |i|
      i.each do |j|
        # Because knights can only move in L shapes (2 up/down 1 left/right || 1 up/down 2 left/right)
        if (j[0] - current[0]).abs == 1 && (j[1] - current[1]).abs == 2 && j != visited.any?(j) && j != starting_pos
          queue << j
        elsif (j[0] - current[0]).abs == 2 && (j[1] - current[1]).abs == 1 && j != visited.any?(j) && j != starting_pos
          queue << j
        end
      end
    end

    if queue.any?(ending_pos)
      visited << ending_pos
    end

    until queue.any?(ending_pos)
      proximity = []
      proximity_hash = {}

      # Fetching the indexes of the positions by using [(7 * row ) + (row + column)]
      queue.each do |i|
        target_idx = (7 * ending_pos.first) + (ending_pos.first + ending_pos.last)
        cur_idx = (7 * i.first) + (i.first + i.last)
        proximity << (target_idx - cur_idx).abs
        proximity_hash[i] = (target_idx - cur_idx).abs

        # To double check on the prevention of having an infinte loop going between 2 positions
        proximity.uniq!
      end

      max_acceptable = if visited.length < 4
        proximity.select { |num| num > 3 }.min
      else
        proximity.select { |num| num <= 17 && num > 6 || num == 2 }.max
      end

      child = proximity_hash.key(max_acceptable)
      proximity.clear
      queue.clear
      possible_moves(board, ending_pos, child, visited, queue) until queue.any?(ending_pos)
    end
    visited
  end

  @moves
end
