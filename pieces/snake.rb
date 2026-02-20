class Snake < Piece
  def symbol
    "3"
  end

  def defeats
    [Spear, Sword, Snake, Bird]
  end

  def replication_moves(board)
    options = []

    offsets1 = [
         [1 * direction, -1], 
         [2 * direction, 0], 
         [3 * direction, 1], 
         [4 * direction, 0] 
        ]

    offsets2 = [
         [-1 * direction, 1], 
         [-2 * direction, 0], 
         [-3 * direction, -1], 
         [-4 * direction, 0] 
        ]
    
    offsets3 = [
         [1 , 1 * direction], 
         [0, 2 * direction], 
         [-1, 3 * direction], 
         [0, 4 * direction] 
        ]

    offsets4 = [
         [1 , -1 * direction], 
         [0, -2 * direction], 
         [-1, -3 * direction], 
         [0, -4 * direction] 
        ]

    row, col = board.find_piece(self)

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
    
    moves = []
    offsets3.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves
    
    moves = []
    offsets4.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves << [r, c]
    end
    options << moves

    options
  end
end
