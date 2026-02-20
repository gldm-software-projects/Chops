require "json"
require_relative "board"

Dir["./pieces/*.rb"].each { |f| require_relative f }

class Game
  attr_reader :board, :current_player

  def initialize
    @board = Board.new
    @current_player = :blue
    setup_pieces
  end

  def setup_pieces
    blue = 7
    red = 0

    # Bianchi
    row = blue
    board.place_piece(Bird.new(color: :blue),   row, 0)
    board.place_piece(Spear.new(color: :blue),  row, 1)
    board.place_piece(Sword.new(color: :blue),  row, 2)
    board.place_piece(Snake.new(color: :blue),  row, 3)
    board.place_piece(Tree.new(color: :blue),   row, 4)
    board.place_piece(Shield.new(color: :blue), row, 5)
    board.place_piece(Spear.new(color: :blue),  row, 6)
    board.place_piece(Bird.new(color: :blue),   row, 7)

    # Neri (specchio)
    row = red
    board.place_piece(Bird.new(color: :red),   row, 0)
    board.place_piece(Spear.new(color: :red),  row, 1)
    board.place_piece(Shield.new(color: :red), row, 2)
    board.place_piece(Tree.new(color: :red),   row, 3)
    board.place_piece(Snake.new(color: :red),  row, 4)
    board.place_piece(Sword.new(color: :red),  row, 5)
    board.place_piece(Spear.new(color: :red),  row, 6)
    board.place_piece(Bird.new(color: :red),   row, 7)
  end

  def game_over?
    board.grid.flatten.none?(&:nil?)
  end

  def winner
    blue = board.grid.flatten.count { |p| p&.color == :blue }
    red = board.grid.flatten.count { |p| p&.color == :red }

    return :blue if blue > red
    return :red if red > blue
    :draw
  end

  def switch_player
    @current_player = (@current_player == :blue ? :red : :blue)
  end

  def all_moves_for(color)
    moves = []

    board.grid.each_with_index do |row, r|
      row.each_with_index do |piece, c|
        next if piece.nil?
        next unless piece.color == color

        reps = piece.replication_moves(board)
        reps.each do |rep|
          moves << { piece: piece, from: [r, c], replication: rep }
        end
      end
    end

    moves
  end

def evaluate_move(move)
  piece = move[:piece]
  rep   = move[:replication]

  score = rep.size  # main criteria: more clones

  rep.each do |r, c|
    occ = board.piece_at(r, c)
    next if occ.nil?
    next if occ.color == piece.color

    # if can beat an enemy: bonus
    score += 2 if piece.defeats.include?(occ.class)
  end

  score
end

def bot_move
  moves = all_moves_for(:red)
  return if moves.empty?

  scored = moves.map do |m|
    [m, evaluate_move(m)]
  end

  best_score = scored.map(&:last).max
  best_moves = scored.select { |_, s| s == best_score }.map(&:first)

  chosen = best_moves.sample

  piece = chosen[:piece]
  rep   = chosen[:replication]

  puts "\nIl bot muove #{piece.class.name} da #{chosen[:from].inspect}"
  puts "Replica in: #{rep.map { |r,c| "(#{r},#{c})" }.join(" ")}"

  board.apply_replication(piece, rep)
end


#def bot_move
  #  moves = all_moves_for(:red)
  #  return if moves.empty?

  #  best_score = moves.map { |m| m[:replication].size }.max
  #  best_moves = moves.select { |m| m[:replication].size == best_score }

  #  chosen = best_moves.sample

  #  piece = chosen[:piece]
  #  rep   = chosen[:replication]

  #  puts "\nComputer moves #{piece.class.name} from #{chosen[:from].inspect}"
  #  board.apply_replication(piece, rep)
 # end

  def ask_piece_selection
    loop do
      print "Select a cell (r c) - S to save the current game, L to load the saved game: "
      input = gets.chomp
      if (input=='L')||(input=='l')
        #LOAD GAME
        load_game()
        board.display
      elsif (input=='S')||(input=='s')
        #SAVE GAME
        save_game()
      else
        r, c = input.split.map(&:to_i)

        piece = board.piece_at(r, c)

        next puts "Empty cell." if piece.nil?
        next puts "It is not a piece of yours." if piece.color != current_player

        return piece
      end
    end
  end

  def ask_replication_choice(options)
    puts "Optional moves:"
    options.each_with_index do |m, i|
      coords = m.map { |r,c| "(#{r},#{c})" }.join(" ")
      puts "#{i}: #{coords}"
    end

    loop do
      print "Please select one: "
      i = gets.chomp.to_i
      # puts "hai scelto #{options[i]}"
      return options[i] if i.between?(0, options.size - 1)
      puts "Selection invalid."
    end
  end

  def human_turn
    piece = ask_piece_selection
    options = piece.replication_moves(board)

    if options.empty?
      puts "This piece cannot move."#puts "Questo pezzo non può replicarsi."
      return
    end

    rep = ask_replication_choice(options)
    # puts "sto passando questi parametri: #{piece}  #{rep}"
    board.apply_replication(piece, rep)
  end

  def save_game(filename = "current_game.json")
    data = {
      current_player: @current_player,
      pieces: []
    }

    board.grid.each_with_index do |row, r|
      row.each_with_index do |p, c|
        next if p.nil?
        data[:pieces] << {
          type: p.class.name,
          color: p.color,
          row: r,
          col: c
        }
      end
    end

    File.write(filename, JSON.pretty_generate(data))
    puts "Game saved."
  end

  def load_game(filename = "current_game.json")
    data = JSON.parse(File.read(filename), symbolize_names: true)

    @board = Board.new
    @current_player = data[:current_player].to_sym

    data[:pieces].each do |p|
      klass = Object.const_get(p[:type])
      piece = klass.new(color: p[:color].to_sym)
      board.place_piece(piece, p[:row], p[:col])
    end

    puts "Game loaded."
  end

  # functions to color the console output
  def colorize(text, color_code)
    "\e[#{color_code}m#{text}\e[0m"
  end
  
  def blink(text); colorize(text, 5); end
  def red(text); colorize(text, 31); end
  def green(text); colorize(text, 32); end
  def yellow(text); colorize(text, 33); end
  def blue(text); colorize(text, 34); end

  def game_loop
    system("cls")
    # descrizione pezzi
    print red("R")
    print "-"
    print yellow("CHOPS")
    print blink("  https://github.com/gldm-software-projects/Chops")
    puts
    puts
    print green("Pieces description")
    puts
    puts "1 = Spear"
    puts "2 = Sword"    
    puts "3 = Snake"
    puts "4 = Tree"
    puts "5 = Shield"
    puts "6 = Bird"
    print green("____________________________________________________________")
    puts
    until game_over?
      #system("clear")
      board.display
      puts "\nTurn: #{@current_player}"

      if @current_player == :blue
        human_turn
      else
        bot_move
        sleep 1
      end

      switch_player
    end

    board.display
    puts "\nGame over!"
    puts "Winner: #{winner}"
  end
end

Game.new.game_loop
