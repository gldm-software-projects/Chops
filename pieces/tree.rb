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

    # Quadrato 5x5 centrato sul Tree 
    (-2..2).each do |dr| 
      (-2..2).each do |dc| 
            r = row + dr 
            c = col + dc 
            next unless board.in_bounds?(r, c) 
            # next unless board.piece_at(r, c).nil? 
            
            # La casella deve avere lo stesso colore della casella di partenza 
            same_color = (@color == :white) ? (r + c).odd? : (r + c).even? 
            next unless same_color
            moves << [r, c]
      end
    end

    options << moves

    options
  end
end
