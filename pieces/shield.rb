class Shield < Piece
  def symbol
    "5"
  end

  def defeats
    [Tree, Shield]
  end

  def replication_moves(board)
    options = []
    moves = []
    row, col = board.find_piece(self)

  # Tutte le 8 caselle attorno 
    [-1, 0, 1].each do |dr| 
        [-1, 0, 1].each do |dc| 
            next if dr == 0 && dc == 0 # esclude la casella di partenza
            r = row + dr
            c = col + dc
            next unless board.in_bounds?(r, c)
            moves << [r, c]
        end
    end

    options << moves

    options
  end
end
