require './lib/player.rb'
require './lib/board.rb'

describe Board do
  let(:player1) { Player.new('Diego', 'O') }
  let(:player2) { Player.new('Luna', 'X') }
  let(:brd) { Board.new([player1, player2]) }

  context 'Initializing Board class:' do
    p1 = Player.new('Diego', 'O')
    p2 = Player.new('Luna', 'X')
    b1 = Board.new([p1, p2])
    it 'Should save both players given by the arguments' do
      expect(b1.players).to contain_exactly(p1, p2)
    end

    it 'Should set the first player as active' do
      expect(b1.players.first).to eql(p1)
    end

    it 'Should set the round number to zero' do
      expect(b1.round).to eql(0)
    end

    it 'Should set all the board slots to \'-\'' do
      expect(b1.board).to all(eq '-')
    end
  end

  context 'Game Flow:' do
    it '#switch_player should switch the @active player' do
      actual = brd.active
      left = brd.players[brd.players.index(actual) - 1]
      expect { brd.switch_player }.to change(brd, :active).from(actual).to(left)
    end

    it '#next_round should increase @round value by 1' do
      actual = brd.round
      expect { brd.next_round }.to change(brd, :round).from(actual).to(actual + 1)
    end

    context '#move' do
      it 'Should return an array with the validation of the movement' do
        expect(brd.move(1, 1)).to be_an(Array)
      end

      it 'Should raise an \'ArgumentError\' error if no arguments where given' do
        expect { brd.move }.to raise_error(ArgumentError)
      end

      it 'Should return \'false\' as the first value of match_data if slot is out of range' do
        expect(brd.move(3, 4).first).to eql false
      end

      it '^ Same value should return \'false\' if slot is already taken' do
        brd.move(2, 2)
        expect(brd.move(2, 2).first).to eql false
      end

      it 'Should return \'true\' as the second value of match_data if a player forms a line' do
        movement = []
        3.times { |i| movement = brd.move(i, i) }
        expect(movement.last).to eql true
      end
    end
  end
end
