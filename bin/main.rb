#!/usr/bin/env ruby
require './lib/game.rb'

puts 'TicTacToe Game...'
print "Player #{Board.avatars[0]} - Enter you name: "
p1 = Player.new(gets.strip, Board.avatars[0])

print "Player #{Board.avatars[1]} - Enter your name: "
p2 = Player.new(gets.strip, Board.avatars[1])

b1 = Board.new([p1, p2])
brd = b1.board
move_res = [false, false]

while b1.round < 9
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

puts "
----------------------------

    1 2 3
1 [ #{brd[0]} #{brd[1]} #{brd[2]} ]
2 [ #{brd[3]} #{brd[4]} #{brd[5]} ]
3 [ #{brd[6]} #{brd[7]} #{brd[8]} ]

"
puts move_res[1] ? "#{b1.active.name} wins! Congratulations!!!" : 'This is a DRAW!!!'
