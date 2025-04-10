# TIC TAC TOE

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

class PlayGame
  WINNING_COMBOS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  PLAYER_ONE_SYMBOL = "O"
  PLAYER_TWO_SYMBOL = "X"

  def initialize
    @player_one = nil
    @player_two = nil
    @current_player = nil
    @board_array = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def getPlayers
    @player_one = createPlayer(1, PLAYER_ONE_SYMBOL)
    @player_two = createPlayer(2, PLAYER_TWO_SYMBOL)
    @current_player = @player_one
  end

  def createPlayer(player_number, symbol)
    loop do
      puts "Enter your name, Player #{player_number}:"
      name = gets.chomp.strip
      return Player.new(name, symbol) unless name.empty?
      puts "Name cannot be empty. Please enter a valid name."
    end
  end

  def startGame
    welcomeMessage
    loop do
      puts "#{@player_one.name} (#{@player_one.symbol}) vs #{@player_two.name} (#{@player_two.symbol})"
      displayBoard
      playGameLoop
      loop do
        puts "Do you want to play again? (yes/no)"
        answer = gets.chomp.downcase
        if answer == "yes"
          resetGame
          break
        elsif answer == "no"
          puts "Thanks for playing!"
          return
        else
          puts "Invalid input. Please ener 'yes' or 'no'."
        end
      end
    end
  end

  def resetGame
    @board_array = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    @current_player = @player_one
  end

  def playGameLoop
    loop do
      playRound
      if checkWin
        puts "#{@current_player.name} wins!"
        break
      elsif checkDraw
        puts "It's a draw!"
        break
      end
      switchPlayer
    end
  end

  def playRound
    loop do
      puts "#{@current_player.name}, please enter your choice (1-9):"
      input = gets.chomp
      choice = input.to_i
      if input.match?(/^\d+$/) && choice.between?(1, 9) && @board_array[choice - 1] == " "
        @board_array[choice - 1] = @current_player.symbol
        displayBoard
        break
      else
        puts "Invalid choice. Please choose a number between 1 and 9."
      end
    end
  end

  def switchPlayer
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def checkWin
    WINNING_COMBOS.any? do |combo|
      combo.all? { |index| @board_array[index - 1] == @current_player.symbol }
    end
  end

  def checkDraw
    @board_array.none? { |cell| cell == " " }
  end

  def displayBoard
    puts "\n"
    puts " #{@board_array[0]} | #{@board_array[1]} | #{@board_array[2]} "
    puts "---+---+---"
    puts " #{@board_array[3]} | #{@board_array[4]} | #{@board_array[5]} "
    puts "---+---+---"
    puts " #{@board_array[6]} | #{@board_array[7]} | #{@board_array[8]} "
    puts "\n"
  end

  def welcomeMessage
    puts "Welcome to Tic-Tac-Toe"
    puts "Player 1 will use 'O' and Player 2 will use 'X'."
    puts "Take turns to place your symbol on the board."
    puts "The first player to align three symbols in a row, column or diagonal wins!"
    puts "Good luck!\n\n"
  end

  def self.play
    game = new
    game.getPlayers
    game.startGame
  end
end

PlayGame.play
