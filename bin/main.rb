#!/usr/bin/env ruby
puts 'TicTacToe Game...'
WIN_CASES = [
  '^(?:O{6}|O{3})?XXX(?:O{6}|O{3})?$',
  '^[B\-]{0,2}(?:A[B\-]{2}){2}A[B\-]{0,2}$',
  '^[B\-]{2}A[B\-]{3}[B\-]$',
  '^(?:A[B\-]{3}){2}A$'
].freeze
syms = %w[X O]
name = ['Player X', 'Player O']

print 'Player X - Enter you name: '
name[0] = gets.strip

print 'Player O - Enter your name: '
name[1] = gets.strip

board = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
winner = false

def winner_move(sym1, sym2, brd)
  win = WIN_CASES.any? { |v| Regexp.new(v.gsub(/[AB]/, 'A' => sym1, 'B' => sym2)).match?(brd.join) }
  win
end

current = 0
i = 0

while i < 9
  puts "
----------------------------

    1 2 3
1 [ #{board[0]} #{board[1]} #{board[2]} ]
2 [ #{board[3]} #{board[4]} #{board[5]} ]
3 [ #{board[6]} #{board[7]} #{board[8]} ]

"
  puts "#{name[current]} - Now it's your turn"

  print "#{name[current]} - Choose a column: "
  col = gets.strip.to_i - 1
  print "#{name[current]} - Choose a row: "
  row = gets.strip.to_i - 1

  pos = (3 * row) + col
  valid = (0..8).include?(pos) && (board[pos] == '-')

  unless valid
    puts "\nWARNING - Your movement isn't valid:\nPlease, choose again...\n\n"
    next
  end

  board[pos] = syms[current]
  winner = winner_move(syms[current], syms[current - 1], board)
  break if winner

  current = current.zero? ? 1 : 0
  i += 1
end

puts "
----------------------------

    1 2 3
1 [ #{board[0]} #{board[1]} #{board[2]} ]
2 [ #{board[3]} #{board[4]} #{board[5]} ]
3 [ #{board[6]} #{board[7]} #{board[8]} ]

"
puts winner ? "#{name[current]} wins! Congratulations!!!" : 'This is a Tie!'
