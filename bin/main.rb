#!/usr/bin/env ruby
require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

# Clear Screen Method
module Screen
  def self.clear
    print "\e[2J\e[f"
  end
end

# While loop repeats the program unless otherwise specified
keep = true
while keep
  Screen.clear
  print '
   ______     _____          _____
  /__  (_) __/__   \__ _  __/__   \___   ___
   / /\/ |/ __|/ /\/ _` |/ __|/ /\/ _ \ / _ \
  / /  | | (__/ / | (_| | (__/ / | (_) |  __/
  \/   |_|\___\/   \__,_|\___\/   \___/ \___|


  1.- Start New Game      >>>
  2.- Change Avatar       <?>
  0.- Exit                <X>

  Choose your option: '
  op = gets.strip.to_i

  # Case switch based on the options above
  case op
  when 0
    # If exit
    puts 'I\'ll miss you :c'
    keep = false
  when 1
    # rubocop:disable Metrics/BlockNesting
    # If New Game
    Screen.clear

    # Request player names
    name = ''
    print "Player #{Board.avatars[0]} - Enter you name: "
    while name.empty?
      name = gets.strip
      p name
      puts('Please enter a valid name...') if name.empty?
    end
    p1 = Player.new(name, Board.avatars[0])

    name = ''
    print "Player #{Board.avatars[1]} - Enter your name: "
    while name.empty?
      name = gets.strip
      p name
      puts('Please enter a valid name...') if name.empty?
    end
    p2 = Player.new(name, Board.avatars[1])

    # Initialize the board
    b1 = Board.new([p1, p2])
    brd = b1.board
    move_res = [false, false]
    valid = true

    # Starts a new round until win or no spaces left
    while b1.round < 9
      Screen.clear
      active = b1.active
      puts "
          1 2 3
      1 [ #{brd[0]} #{brd[1]} #{brd[2]} ]
      2 [ #{brd[3]} #{brd[4]} #{brd[5]} ]
      3 [ #{brd[6]} #{brd[7]} #{brd[8]} ]

      "
      puts "# WARNING: Invalid movement\n# Please try again..." unless valid
      valid = true
      puts "#{active.name} - Now it's your turn"

      # Request movement
      print "#{active.name} - Choose a column: "
      col = gets.strip.to_i - 1
      print "#{active.name} - Choose a row: "
      row = gets.strip.to_i - 1

      # Register the move and check if wins
      move_res = b1.move(col, row)

      unless move_res[0]
        valid = false
        next
      end

      # If wins the game ends
      break if move_res[1]

      # If not switch players and starts again
      b1.switch_player
      b1.next_round
    end
    # rubocop:enable Metrics/BlockNesting

    Screen.clear
    puts "
    =============

        1 2 3
    1 [ #{brd[0]} #{brd[1]} #{brd[2]} ]
    2 [ #{brd[3]} #{brd[4]} #{brd[5]} ]
    3 [ #{brd[6]} #{brd[7]} #{brd[8]} ]

    "

    # Prints a message based on the results above
    puts move_res[1] ? "#{b1.active.name} wins! Congratulations!!!" : 'This is a DRAW!!!'
    puts 'Do you want to play again? (Y/N) '
    keep = false if gets.strip.downcase == 'n'
  when 2
    # If change avatar, request the new ones
    print "Enter the character for Player #{Board.avatars[0]}: "
    av1 = gets.strip
    Board.avatars[0] = av1 unless av1.length > 1 || av1.empty?
    print "Enter the character for Player #{Board.avatars[1]}: "
    av2 = gets.strip
    Board.avatars[1] = av2 unless av2.length > 1 || av2.empty?
    if Board.avatars == [av1, av2] then puts "Avatars saved successfully!!!\n[Press Enter to continue]"
    else puts "Invalid avatars, reverting changes\n[Press Enter to continue]"
    end
    gets
  else
    puts 'Choose a valid option'
  end
end
