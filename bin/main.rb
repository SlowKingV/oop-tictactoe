#!/usr/bin/env ruby
require_relative '../lib/board.rb'
require_relative '../lib/player.rb'

module Screen
  def self.clear
    print "\e[2J\e[f"
  end
end

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

  case op
  when 0
    puts 'I\'ll miss you :c'
    keep = false
  when 1
    Screen.clear
    print "Player #{Board.avatars[0]} - Enter you name: "
    p1 = Player.new(gets.strip, Board.avatars[0])

    print "Player #{Board.avatars[1]} - Enter your name: "
    p2 = Player.new(gets.strip, Board.avatars[1])

    b1 = Board.new([p1, p2])
    brd = b1.board
    move_res = [false, false]

    # rubocop:disable Metrics/BlockNesting
    while b1.round < 9
      Screen.clear
      active = b1.active
      puts "
      ----------------------------

          1 2 3
      1 [ #{brd[0]} #{brd[1]} #{brd[2]} ]
      2 [ #{brd[3]} #{brd[4]} #{brd[5]} ]
      3 [ #{brd[6]} #{brd[7]} #{brd[8]} ]

      "
      puts "#{active.name} - Now it's your turn"

      print "#{active.name} - Choose a column: "
      col = gets.strip.to_i - 1
      print "#{active.name} - Choose a row: "
      row = gets.strip.to_i - 1

      move_res = b1.move(col, row)

      unless move_res[0]
        puts "\nWARNING - Your movement isn't valid:\nPlease, choose again...\n\n"
        next
      end

      break if move_res[1]

      b1.switch_player
      b1.next_round
    end
    # rubocop:enable Metrics/BlockNesting

    puts "
    ----------------------------

        1 2 3
    1 [ #{brd[0]} #{brd[1]} #{brd[2]} ]
    2 [ #{brd[3]} #{brd[4]} #{brd[5]} ]
    3 [ #{brd[6]} #{brd[7]} #{brd[8]} ]

    "
    puts move_res[1] ? "#{b1.active.name} wins! Congratulations!!!" : 'This is a DRAW!!!'
    puts 'Do you want to play again? (Y/N) '
    keep = false if gets.strip.downcase == 'n'
  when 2
    print "Enter the character for Player #{Board.avatars[0]}: "
    av = gets.strip
    Board.avatars[0] = av unless av.length > 1
    print "Enter the character for Player #{Board.avatars[1]}: "
    av = gets.strip
    Board.avatars[0] = av unless av.length > 1
  else
    puts 'Choose a valid option'
  end
end
