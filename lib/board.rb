WIN_CASES = [
  '^(?:[B\-]{6}|[B\-]{3})?AAA(?:[B\-]{6}|[B\-]{3})?$', # Win case for HORIZONTAL line (e.g. OOO XXX OOO)
  '^[B\-]{0,2}(?:A[B\-]{2}){2}A[B\-]{0,2}$', # Win case for VERTICAL line (e.g. OXO OXO OXO)
  '^[B\-]{2}(?:A[B\-]){3}[B\-]$', # Win case for FORWARD DIAGONAL line (e.g. OOX OXO XOO)
  '^(?:A[B\-]{3}){2}A$' # Win case for BACKWARD DIAGONAL line (e.g. XOO OXO OOX)
].freeze

# Board Class which stores all the Game related data like board state, players, round number, the active player, etc
class Board
  @avatars = %w[X O]
  @players = []
  def initialize(players)
    @players = players
    @active = players[0]
    @round = 0
    @board = ['-', '-', '-', '-', '-', '-', '-', '-', '-']
  end

  attr_reader :board, :round, :active
  class << self
    attr_reader :avatars
  end

  def switch_player
    @active = @active == @players[0] ? @players[1] : @players[0]
  end

  def next_round
    @round += 1
  end

  def move(col, row)
    pos = (3 * row) + col
    valid = if move_valid(col, row, pos)
              @board[pos] = @active.avatar
              true
            else
              false
            end
    win = winner
    move_data = [valid, win]
    p move_data
    move_data
  end

  private

  def move_valid(col, row, pos)
    ((0..2).include?(col) && (0..2).include?(row)) && @board[pos] == '-'
  end

  def winner
    avatar1 = @active.avatar
    avatar2 = @players.difference([@active]).first.avatar
    WIN_CASES.any? { |win_case| Regexp.new(win_case.gsub(/[AB]/, 'A' => avatar1, 'B' => avatar2)).match?(@board.join) }
  end
end
