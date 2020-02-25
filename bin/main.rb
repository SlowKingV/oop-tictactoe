#!/usr/bin/env ruby
puts 'TicTacToe Game...'

print 'Player X - Enter you name: '
name1 = gets.strip

print 'Player O - Enter your name: '
name2 = gets.strip

board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]

puts "
    1 2 3
1 [ #{board[0][0]} #{board[0][1]} #{board[0][2]} ]
2 [ #{board[1][0]} #{board[1][1]} #{board[1][2]} ]
3 [ #{board[2][0]} #{board[2][1]} #{board[2][2]} ]
----------------------------
"

print "#{name1} - Choose a row: "
row = gets.strip.to_i

print "#{name1} - Choose a column: "
column = gets.strip.to_i

board[row - 1][column - 1] = 'X'

puts "
    1 2 3
1 [ #{board[0][0]} #{board[0][1]} #{board[0][2]} ]
2 [ #{board[1][0]} #{board[1][1]} #{board[1][2]} ]
3 [ #{board[2][0]} #{board[2][1]} #{board[2][2]} ]
----------------------------
"

print "#{name2} - Choose a row: "
row = gets.strip.to_i

print "#{name2} - Choose a column: "
column = gets.strip.to_i

board[row - 1][column - 1] = 'O'

puts "
    1 2 3
1 [ #{board[0][0]} #{board[0][1]} #{board[0][2]} ]
2 [ #{board[1][0]} #{board[1][1]} #{board[1][2]} ]
3 [ #{board[2][0]} #{board[2][1]} #{board[2][2]} ]
----------------------------
"

puts 'Once you align three symbols you WIN!'
