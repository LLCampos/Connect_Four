require 'connect_four.rb'

describe '.Grid' do

  describe '.new' do
    it 'returns an empty grid' do
      expect(Grid.new.grid).to eq([[' '] * 6] * 7)
    end
  end

  describe '#add' do
    before do
      @grid1 = Grid.new
      @grid1.add('white', 1)
      @grid2 = Grid.new
      3.times { @grid2.add('black', 3) }
    end

    it 'has a disk in second column, bottom row' do
      expect(@grid1.grid[1][5]).to eql('white')
    end

    it 'has three disks in the bottom of fourth column' do
      expect(@grid2.grid[3][3..5]).to eql(['black', 'black', 'black'])
    end

    context 'column is full' do
      before do
        @grid3 = Grid.new
        6.times { @grid3.add('white', 1) }
      end
      it 'returns false' do
        expect(@grid3.add('white', 1)).to eql(nil)
      end
    end
  end

  describe '#four_connected?' do
    before :all do
      @vertical = Grid.new
      4.times { @vertical.add('black', 2) }

      @horizontal = Grid.new
      (1..4).each do |n|
        @horizontal.add('black', n)
      end

      @vertical_no = Grid.new
      3.times { @vertical_no.add('black', 2) }
      @vertical_no.add('white', 2)

      @horizontal_no = Grid.new
      (1..3).each do |n|
        @horizontal_no.add('black', n)
      end
      @horizontal_no.add('white', 4)

      @diagonal1 = Grid.new
      (1..4).each do |n|
        (1..n).each do |x|
          @diagonal1.add('black', x)
        end
      end
      @diagonal1.grid[1][5] = 'white'


      @diagonal2 = Grid.new
      (1..4).each do |n|
        n.times { @diagonal2.add('black', n) }
      end
      @diagonal2.grid[4][5] = 'white'
    end

    context 'empty grid' do
      before do
        @empty_grid = Grid.new

      end
      it 'returns false' do
        expect(@empty_grid.four_connected?('black')).to eql(false)
      end
    end

    context 'four disks of the same color connected vertically' do
      it 'returns true if the game is finished' do
        expect(@vertical.four_connected?('black')).to eql(true)
      end
    end

    context 'four disks of the same color connected horizontally' do
      it 'returns true if the game is finished' do
        expect(@horizontal.four_connected?('black')).to eql(true)
      end
    end

    context 'four disks connected horizontally, but not of the same color' do
      it 'returns false' do
        expect(@horizontal_no.four_connected?('black')).to eql(false)
      end
    end

    context 'four disks connected vertically, but not of the same color' do
      it 'returns false' do
        expect(@vertical_no.four_connected?('white')).to eql(false)
      end
    end

    context 'four disks of the same color connected diagonally' do

      it 'returns true if four connected diagonally' do
        expect(@diagonal1.four_connected?('black')).to eql(true)
        expect(@diagonal2.four_connected?('black')).to eql(true)
      end

    end

    context 'four disks of different color connected diagonally' do

      before do
        @diagonal1.grid[4][5] = 'white'
        @diagonal2.grid[1][5] = 'white'
      end

      it 'returns true if not four connected diagonally' do
        expect(@diagonal1.four_connected?('black')).to eql(false)
        expect(@diagonal2.four_connected?('black')).to eql(false)
      end
    end
  end


  describe '#full?' do

    context 'when grid is full' do
      before do
        @full = Grid.new
        (0..6).each do |n|
          6.times { @full.add('black', n) }
        end
      end
      it 'returns true' do
        expect(@full.full?).to eql(true)
      end
    end

    context 'when grid is empty' do
      before do
        @empty = Grid.new
      end
      it 'returns false' do
        expect(@empty.full?).to eql(false)
      end
    end

    context 'when grid has 1 disk' do
      before do
        @one_disk = Grid.new
        @one_disk.add('black', 3)
      end
      it 'returns false' do
        expect(@one_disk.full?).to eql(false)
      end
    end
  end
end

