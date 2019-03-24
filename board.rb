require_relative 'node'

# Class that represents a board of the game
class Board
  # -- Acessors
  attr_accessor :size
  attr_reader :values
  attr_reader :root
  attr_reader :final_state

  # Initializer
  def initialize(size, final_state = nil)
    @size = size
    @current_state = random_board
    @root = Node.new(@current_state)
    @final_state =  if final_state.nil?
                      Node.new(
                        [
                          [1, 2, 3],
                          [4, 5, 6],
                          [7, 8, 0]
                        ]
                      )
                    else
                      Node.new(final_state)
                    end
  end

  # Pretty Print
  def pretty_print
    puts '--- Board ---'
    pretty_print_line_divider
    @current_state.each do |row|
      pretty_print_row(row)
      pretty_print_line_divider
    end
  end

  # Given a state returns true or false based on wheter it is the desired
  # solution
  def solution?(state)
    state.current_state == final_state.current_state
  end

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
    # Gets parity and blank position
    parity, blank = get_parity_and_blank(board.flatten)

    # Checks based on parity and blank position if it is solvable
    check_parity_and_blank(parity, blank)
  end
  # ----------

  # Calculates parity and blank position for a flattened (1 dimension) board
  def get_parity_and_blank(flattened_board)
    # Current row
    row = 0
    # Parity
    parity = 0
    # Row with the blank space
    blank = 0

    (0..(size - 1)).each do |i|
      # Advance to next row if
      row += 1 if i % size

      if flattened_board[i].zero?
        blank = row
        next
      end

      # Updates parity
      parity = update_parity(flattened_board, parity, i)
    end

    # Return parity and blank
    [parity, blank]
  end

  # Updates parity of a flattened board given a certain position
  def update_parity(flattened_board, parity, current_pos)
    # Loops through next positions, updating parity
    ((current_pos + 1)..(flattened_board.length - 1)).each do |j|
      if  flattened_board[current_pos] > flattened_board[j] &&
          flattened_board[j] != 0
        parity += 1
      end
    end

    # Returns updated parity
    parity
  end

  # Checks based on board size, parity and blank position
  # if the board is solvable
  def check_parity_and_blank(parity, blank)
    if size.even?
      if blank.even?
        parity.even?
      else
        parity.odd?
      end
    else
      parity.even?
    end
  end


  # ------------Pretty Print Auxiliary Methods

  # Auxiliary function to print a row of the board separated by '|'
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

  # Auxiliary function to print a line divider
  def pretty_print_line_divider
    size.times { printf '--' }
    printf "-\n"
  end
  # ----------
end
