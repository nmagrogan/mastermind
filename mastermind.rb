# frozen_string_literal: false

# Game board class, contains all of the rows for the game.
class GameBoard
  # stores a certain number of rows, the code to be guessed
  # displays the game board

  def initialize
    @rows = [] # rows initally and empty array, a new row object gets appended each turn
    @code = [0, 0, 0, 0]
  end

  def display_board
    puts 'Guess                Response'
    @rows.each { |row| row.display }
  end

  def code
    # @code = input
    # above is for user input code(to be used later when adapted to let computer make guesses)
    letters = ('A'..'F').to_a
    @code = @code.map { letters[rand(letters.length)] }
  end

  def row
    row = Row.new(input, @code)
    @rows << row
    row.player_won
  end

  def input
    input_arr = []
    for i in 1..4
      puts "Input peg #{i}"
      puts '(A,B,C,D,E,F)'
      input_arr << gets.chomp
    end
    input_arr
  end

  def display_code
    p @code
  end
end

# Row class, each row is for each turn of the game, stores the CodeBreaker's guess and the CodeSetter's response
class Row
  # stores the guessed code, and code setters response
  # display a row
  # checks if guess is correct
  attr_reader :player_won
  def initialize(input, code)
    @guesses = input
    @response = []
    @player_won = response(code) # needs to determine response based on input
    @response.shuffle!
  end

  def display
    print(@guesses, ' ', @response, "\n")
  end

  def response(code)
    return true if @guesses == code

    @guesses.each_with_index do |guess, i|
      #binding.pry
      if code.include?(guess) && @guesses[i] == code[i]
        @response << 'x'
      elsif code.include? guess
        @response << 'o'
      else
        @response << '_'
      end
    end
    false
  end
end

# Game class runs the game, keeps track of number of turns etc.
class Game
  # Initalizes the game
  # keeps track of how many turns have gone by
  # displays who won the game
  def initialize(turns)
    @turns = turns
    @board = GameBoard.new
    @gameover = false
  end

  def turn
    @board.display_board
    @board.row
  end

  def play
    turn_count = 0
    puts 'Welcome to master mind.'
    puts 'rules.....'
    @board.code # makes computer generate code
    @board.display_code

    until @gameover || turn_count >= @turns
      @board.display_board
      @gameover = @board.row
      turn_count += 1
    end

    @board.display_board
    puts 'Actual Code'
    @board.display_code
    puts 'Congrats you won' if @gameover
  end
end

new_game = Game.new(12)
new_game.play
