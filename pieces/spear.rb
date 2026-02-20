require_relative "piece"
class Spear < Piece
  def symbol
    "1"
  end

  def defeats
    [Spear, Sword, Bird]
  end

  def replication_moves(board)
    options = []
    row, col = board.find_piece(self)

    offsets1 = [[1 * direction, 0], [2 * direction, 0], [3 * direction, 0]]
    offsets2 = [[1, 0], [-1, 0], [0, -1], [0, 1]]

    moves = []
    offsets1.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves

    moves = []
    offsets2.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves
    
    options
  end
end
