load 'board.rb'

def test
  b = Board.new(3)
  search(b)
end

def search(board, type = 'breadth', interval_size = 5)
  byebug
  solution_state =  if type == 'breadth'
                      breadth_search(board)
                    elsif type == 'depth'
                      depth_search(board)
                    elsif type == 'iterative'
                      iterative_deepening_depth_search(board, interval_size)
                    else
                      puts "No search found with the name #{type}"
                      nil
                    end
  return if solution_state.nil?

  movements = movement_trace(solution_state)
  puts 'Initial Board:'
  board.pretty_print
  puts 'Movements to Solve:'
  pretty_print_movement_trace(movements)
  puts 'Final Board:'
  pretty_print(solution_state.current_state)
end

# ------------ Search algorithms

# -- Breadth Search
def breadth_search(board)
  queue = []
  queue.push(board.root)

  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:'
  board.pretty_print

  loop do
    # Gets state
    state = queue.shift(1).first

    # Prints number of states analyzed and current queue
    puts "Analyzed States: #{analyzed_states}"
    puts "Current Queue Size: #{queue.length}"
    puts "Current Level: #{state.level}\n\n"

    # Breaks if it is the solution
    return state if board.solution?(state)

    # Pushes children into the queue
    queue += state.children

    # Breaks if queue is empty
    break if queue.empty?

    # Bumps analyzed states counter
    analyzed_states += 1
  end

  # No solution, returns empty array
  []
end

# -- Depth Search
def depth_search(board)
  queue = []
  queue.push(board.root)

  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:'
  board.pretty_print

  loop do
    # Gets state
    state = queue.pop
    # Prints number of states analyzed and current queue
    puts "Analyzed States: #{analyzed_states}"
    puts "Current Queue Size: #{queue.length}"
    puts "Current Level: #{state.level}\n\n"

    # Breaks if it is the solution
    return state if board.solution?(state)

    # Pushes children into the queue
    queue += state.children

    # Breaks if queue is empty
    break if queue.empty?

    # Bumps analyzed states counter
    analyzed_states += 1
  end

  # No solution, returns empty array
  []
end

# -- Depth Search
def iterative_deepening_depth_search(board, interval_size = 5)
  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:'
  board.pretty_print

  # Initialize max depth
  max_level = 0

  loop do
    # Updates max depth
    max_level += interval_size

    # Initialize queue
    queue = []
    queue.push(board.root)

    puts "\n\n-----\nCurrent Max Depth: #{max_level}:"

    loop do
      # Gets state
      state = queue.pop
      # Prints number of states analyzed and current queue
      puts "Analyzed States: #{analyzed_states}"
      puts "Current Queue Size: #{queue.length}"
      puts "Current Level: #{state.level}\n\n"

      # Breaks if it is the solution
      return state if board.solution?(state)

      # Pushes children into the queue
      queue += state.children if state.level < max_level

      # Breaks if queue is empty
      break if queue.empty?

      # Bumps analyzed states counter
      analyzed_states += 1
    end

    # Breaks if reached level 30 with no solution found
    break if max_level > 30
  end

  # No solution, returns empty array
  []
end

def astar(board, heuristic = 1)

  visited = []
  queue = [board.root]

  # Prints initial board
  puts 'Starting board:'
  board.pretty_print

end

# ------------ Methods for Movement Trace to Solution

# Given a final solution state, returns an array of movements that solves
# the puzzle
def movement_trace(final_state)
  movements = []
  father_state = final_state

  loop do
    # Updates current father and child state
    child_state = father_state
    father_state = father_state.father

    # Add to the beginning of the array the movement from current father
    # state to reach it's child
    movements.unshift(
      unless father_state. nil?
        if father_state.up_child == child_state
          'Up'
        elsif father_state.down_child == child_state
          'Down'
        elsif father_state.left_child == child_state
          'Left'
        else
          'Rigth'
        end
      end
    )

    # Breaks if father_state is nil, meaning it got past the root node
    break if father_state.nil?
  end

  # Returns array with movements to solve the puzzle
  movements
end

def pretty_print_movement_trace(movements)
  movements.each_with_index do |mov, index|
    printf(mov.to_s)
    printf(' -> ') unless index == (movements.length - 1)
  end
  printf("\n\n")
end

# ------------ Pretty Print Methods

# Pretty Print
def pretty_print(state)
  puts '--- Board ---'
  pretty_print_line_divider(state.length)
  state.each do |row|
    pretty_print_row(row)
    pretty_print_line_divider(state.length)
  end
end

private

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
def pretty_print_line_divider(size)
  size.times { printf '--' }
  printf "-\n"
end
