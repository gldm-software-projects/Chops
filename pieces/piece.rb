class Piece
  attr_reader :color

  def initialize(color:)
    @color = color
  end

  def direction 
    @color == :white ? -1 : 1
  end

  def symbol
    "?"
  end

  # Ogni pezzo deve implementare:
  # - replication_moves(board)
  # - defeats (lista classi che può battere)
end
