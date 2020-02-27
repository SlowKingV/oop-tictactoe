#!/usr/bin/env ruby
puts 'TicTacToe Game...'
WIN_CASES = [
  'AAA[B\-]{6}',
  '[B\-]{3}AAA[B\-]{3}',
  '[B\-]{6}AAA',
  '[B\-]{0,2}A[B\-]{2}A[B\-]{2}A[B\-]{0,2}',
  '[B\-][B\-]A[B\-]A[B\-]A[B\-][B\-]',
  'A[B\-][B\-][B\-]A[B\-][B\-][B\-]A'
].freeze
syms = %w[X O]
name = ['Player X', 'Player O']

print 'Player X - Enter you name: '
name[0] = gets.strip

print 'Player O - Enter your name: '
name[1] = gets.strip

board = [['-', '-', '-'], ['-', '-', '-'], ['-', '-', '-']]
winner = false

def winner_move(sym1, sym2, brd)
  win = WIN_CASES.any? { |v| Regexp.new(v.gsub(/[AB]/, 'A' => sym1, 'B' => sym2)).match?(brd.flatten.join) }
  win
end

current = 0
i = 0

while i < 9
  puts "
----------------------------

    1 2 3
1 [ #{board[0][0]} #{board[0][1]} #{board[0][2]} ]
2 [ #{board[1][0]} #{board[1][1]} #{board[1][2]} ]
3 [ #{board[2][0]} #{board[2][1]} #{board[2][2]} ]

"
  puts "#{name[current]} - Now it's your turn"

  print "#{name[current]} - Choose a column: "
  col = gets.strip.to_i
  print "#{name[current]} - Choose a row: "
  row = gets.strip.to_i

  valid = ((1..3).include?(col) && (1..3).include?(row)) && (board[row - 1][col - 1] == '-')

  unless valid
    puts "\nWARNING - Your movement isn't valid:\nPlease, choose again...\n\n"
    next
  end

  board[row - 1][col - 1] = syms[current]
  winner = winner_move(syms[current], syms[current - 1], board)
  break if winner

  current = current.zero? ? 1 : 0
  i += 1
end

puts "
----------------------------

    1 2 3
1 [ #{board[0][0]} #{board[0][1]} #{board[0][2]} ]
2 [ #{board[1][0]} #{board[1][1]} #{board[1][2]} ]
3 [ #{board[2][0]} #{board[2][1]} #{board[2][2]} ]

"
puts winner ? "#{name[current]} wins! Congratulations!!!" : 'This is a Tie!'
