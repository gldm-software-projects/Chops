class Sword < Piece
  def symbol
    "2"
  end

  def defeats
    [Spear, Sword, Snake, Tree, Bird]
  end

  def replication_moves(board)
    options = []

    # Offsets diagonali verso l'alto (per i bianchi) 
    diag_left = [[1 * direction, -1], [2 * direction, -2], [3 * direction, -3]] 
    diag_right = [[1 * direction, 1], [2 * direction, 2], [3 * direction, 3]]
    both = [[1 * direction, 1], [1 * direction, -1], [-1 * direction, 1], [-1 * direction, -1]]
    
    row, col = board.find_piece(self)

    moves = []
    diag_left.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves

    altmoves = []
    diag_right.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      altmoves << [r, c]
    end
    options << altmoves

    bothmoves = []
    both.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      bothmoves << [r, c]
    end
    options << bothmoves

    options
  end
end
