
require_relative "abstgame"

# a game with human interaction
class HumanGame<AbstGame
  
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
 
end

#Game.new.game_loop