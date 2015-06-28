require 'connect_four.rb'

describe '.Grid' do

  describe '.new' do
    it  'returns an empty grid' do
      expect(Grid.new.grid).to eq([[' '] * 6] * 7)
    end
  end

  describe '#add' do

    before do
      @grid1 = Grid.new
      @grid1.add(@white, 1)
      @grid2 = Grid.new
      3.times { @grid2.add(@black, 3) }
    end

    it 'has a disk in second column, bottom row' do
      expect(@grid1.grid[1][5]).to eql(@white)
    end

    it 'has three disks in the bottom of fourth column' do
      expect(@grid2.grid[3][3..5]).to eql([@black, @black, @black])
    end
  end

#it 'test' do
 # expect(test).to output('aa').to_stdout
#end

  describe '#four_connected?' do
    context 'four disks of the same color connected vertically' do
      before do
        @vertical_win = Grid.new
        4.times { @vertical_win.add(@black, 2) }
      end

      it 'returns true if the game is finished' do
        expect(@vertical_win.four_connected?(@black)).to eql(true)
      end
    end

    context 'four disks of the same color connected horizontally' do
      before do
        @horizontal_win = Grid.new
        (1..4).each do |n|
          @horizontal_win.add(@black, n)
        end
      end

      it 'returns true if the game is finished' do
        expect(@horizontal_win.four_connected?(@black)).to eql(true)
      end
    end

    context 'four disks of the same color connected diagona' do
      before do
        @diagonal_win1 = Grid.new
        @diagonal_win2 = Grid.new
      end
    end



  end
end

