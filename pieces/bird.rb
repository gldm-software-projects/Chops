require_relative "piece"
class Bird < Piece
  def symbol
    "6"
  end

  def defeats
    [Spear, Sword, Snake, Tree, Shield, Bird]
  end

  def replication_moves(board)
    options = []
    
    row, col = board.find_piece(self)

    directions = [
     [-3, -3], 
     [-3, 3], 
     [ 3, -3], 
     [ 3, 3]
    ]

    directions.each do |dr, dc|
      r = row + dr
      c = col + dc
      next unless board.in_bounds?(r, c)
      moves = []
      moves << [r, c]
      options << moves
    end

    options
  end
end
