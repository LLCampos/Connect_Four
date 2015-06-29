class Grid
  attr_accessor :grid

  def initialize
    @grid = [[' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6]
  end

  # show the grid to the user
  def show
    @grid.transpose.each do |line|
      puts '| ' + line.join(' | ') + ' |'
    end
  end

  # adds a disk to the column
  def add(color, column)
    empty = [5, 4, 3, 2, 1, 0].find do |n|
      @grid[column][n] == ' '
    end
    empty.nil? ? nil : @grid[column][empty] = color
  end

  def four_connected?(disk)
    four_connected_vertical?(disk) || four_connected_horizontally?(disk)
  end

  def four_connected_vertical?(disk)
    result = false
    @grid.each do |column|
      result = true if [column[2..5], column[1..4], column[0..3]].include?([disk] * 4)
    end
    result
  end

  def four_connected_horizontally?(disk)
    result = false
    @grid.transpose.each do |column|
      result = true if [column[2..5], column[1..4], column[0..3], column[3..6]].include?([disk] * 4)
    end
    result
  end

  # returns true if grid is full, false if it is not
  def full?
    result = true
    @grid.each do |column|
      result = false if column.include?(' ')
    end
    result
  end

end



@white = "\u{25CF}"
@black = "\u{25EF}"


#6.times do puts '| ' + ([''] * 7).join(' | ') + ' |' end




