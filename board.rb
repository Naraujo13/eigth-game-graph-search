# Class that represents a board of the game
class Board

  # Initializer
  def initialize(size)
    @size = size
    @values = random_board
  end

  # Pretty Print
  def pretty_print
    puts '--- Board ---'
    pretty_print_line_divider
    @values.each do |row|
      pretty_print_row(row)
      pretty_print_line_divider
    end
  end

  # -- Acessors
  attr_accessor :size
  attr_reader :values

  private

  # ---------- Board Auxiliary Methods

  # Generaters a new valid board
  def new_board
    random_board
  end

  # Generates a new random board
  # TODO: check assigned branch condition of this method
  def random_board
    # Loop generating random boards until one solvable comes up
    loop do
      # Initialize array with sequential values and then shuffles
      temp = (0..(size * size - 1)).to_a.shuffle

      # Put shuffled values in two dimensional square matrix and returns
      board = Array.new(@size) do |i|
        Array.new(size) { |j| temp[i * size + j] }
      end

      # break loop and returns board if it is solvable
      return board if solvable(board)
    end
  end

  # Given a board, check if it has a valid solution
  def solvable(board)
    true
  end
  # ----------

  # ------------Pretty Print Auxiliary Methods
  def pretty_print_row(row)
    row.each do |e| 
      if e.zero?
        printf '| '
      else
        printf "|#{e}"
      end
    end
    printf "|\n"
  end

  def pretty_print_line_divider
    size.times { printf '--' }
    printf "-\n"
  end
  # ----------
end
