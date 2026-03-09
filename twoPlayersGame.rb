require_relative "humanGame"

# a console game with one player against another
class TwoPlayersGame<HumanGame

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
      board.consoleDisplay
      puts "\nTurn: #{@current_player}"

      if @current_player == :blue
        human_turn
      else
        #bot_move(:red)
        human_turn 
      end

      switch_player
    end

    board.consoleDisplay
    puts "\nGame over!"
    puts "Winner: #{winner}"
  end

end

TwoPlayersGame.new.game_loop