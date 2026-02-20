class Tree < Piece
  def symbol
    "4"
  end

  def defeats
    [Spear, Snake, Tree]
  end

  def replication_moves(board)
    options = []
    moves = []
    row, col = board.find_piece(self)

    offsets = [[1, 1], [-1, -1], [1, -1], [-1, 1], [0, 2], [0, -2], [2, 0], [-2, 0]]

    offsets.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves

    options
  end
end
