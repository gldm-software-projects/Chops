class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def in_bounds?(r, c)
    r.between?(0,7) && c.between?(0,7)
  end

  def piece_at(r, c)
    grid[r][c]
  end

  def place_piece(piece, r, c)
    grid[r][c] = piece
  end

  def remove_piece(r, c)
    grid[r][c] = nil
  end

  def find_piece(piece)
    grid.each_with_index do |row, r|
      row.each_with_index do |p, c|
        return [r, c] if p == piece
      end
    end
    nil
  end

  def apply_replication(piece, positions)
    
    ## traduco l'array di coppie in lista di coppie?
    # positions.each_with_index do |m, i|
    #  puts " -  #{m}"
    #  #couples = m.map { |r,c| "(#{r},#{c})" }.join(" ")
    #   #puts "#{i}: #{coords}"
    # end

    #processo la lista di coppie
    positions.each do |(r, c)|
      resolve_single_replication(piece, r, c)
    end
  end

  def resolve_single_replication(piece, r, c)
    occ = piece_at(r, c)

    if occ.nil?
      place_piece(piece.class.new(color: piece.color), r, c)
      return
    end

    return if occ.color == piece.color

    handle_conflict(piece, occ, r, c)
  end

  def handle_conflict(attacker, defender, r, c)
    if attacker.defeats.include?(defender.class)
      remove_piece(r, c)
      place_piece(attacker.class.new(color: attacker.color), r, c)
    end
  end

  # functions to color the console output
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
  def red(text); colorize(text, 31); end
  def blue(text); colorize(text, 34); end

  def display
    puts "\n   0 1 2 3 4 5 6 7"
    puts "  _________________"
    grid.each_with_index do |row, r|
      print "#{r} |"
      row.each do |p|        
        print(p ? (p.direction==1 ? red(p.symbol): blue(p.symbol)) : ".")
        print " "
      end
      puts
    end
  end
end
