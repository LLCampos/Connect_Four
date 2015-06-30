class Grid
  attr_accessor :grid

  def initialize
    @grid = [[' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6, [' '] * 6]
  end

  # show the grid to the user
  def show
    puts "  " + [1, 2, 3, 4, 5, 6, 7].join('   ')
    @grid.transpose.each do |line|
      puts '| ' + line.join(' | ') + " |"
    end
    puts "\n"
  end

  # adds a disk to the column
  def add(color, column)
    empty = [5, 4, 3, 2, 1, 0].find do |n|
      @grid[column][n] == ' '
    end
    empty.nil? ? nil : @grid[column][empty] = color
  end

  def four_connected?(disk)
    four_connected_vertical?(disk) || four_connected_horizontally?(disk) || four_connected_diagonally?(disk)
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

  # returns the diagonals (upper-left <-> bottom-right) with length 4
  def diagonals
    diag = grid.map.with_index do |column, indexc|
      column.map.with_index do |_, indexp|
        [0, 1, 2, 3].map do |n|
          next if (a = indexc + n) > 6 || (b = indexp + n) > 5
          grid[a][b]
        end
      end
    end
    diag.flatten(1).map(&:compact).select { |d| d.length == 4 }
  end

  # returns the diagonals (upper-right <-> bottom-left) with length 4
  def other_diagonals
    reverse_grid = grid.map(&:reverse)
    diag = reverse_grid.map.with_index do |column, indexc|
      column.map.with_index do |_, indexp|
        [0, 1, 2, 3].map do |n|
          next if (a = indexc + n) > 6 || (b = indexp + n) > 5
          reverse_grid[a][b]
        end
      end
    end
    diag.flatten(1).map(&:compact).select { |d| d.length == 4 }
  end

  def four_connected_diagonally?(disk)
    (diagonals + other_diagonals).include?([disk] * 4)
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

def ask_user(player_number)
  puts "Player #{player_number}, in which column do you want to put your disk?"
  input = gets.chomp.to_i
  unless [1, 2, 3, 4, 5, 6, 7].include?(input)
    puts 'You have to insert in one of the columns!'
    ask_user(player_number)
  else
    input
  end
end

def turn(disk_color, player_number)
  input = ask_user(player_number)
  if @game.add(disk_color, input - 1).nil?
    puts 'That column is already full, choose another!'
    turn(disk_color, player_number)
  end
  @game.show
  if @game.four_connected?(disk_color)
    puts "Congratulations, Player #{player_number}, you won the game!\n\n"
    new_game
  elsif @game.full?
    puts "It's a tie!"
    new_game
  end
end

def new_game
  @game = Grid.new
  puts "Welcome to Connect Four :D"
  puts "Press CTRL + C anytime to finish your game session"
  puts "Player 1 will play with the Black disks and Player 2 with the White disks\n\n"
  @game.show
  loop do
    turn(@black, '1')
    turn(@white, '2')
  end
end

new_game




