load 'board.rb'

require 'fc'

def test(type = 'astar', search_param = 'manhattan', board = nil, debug = false)
  b = if board.nil?
        Board.new(3)
      else
        board
      end
  a = Time.now
  search(b, type, search_param, debug)
  puts "Tempo: #{Time.now - a}"
end

def search(board, type = 'breadth', search_param = 'manhattan', debug = false)
  puts "Initial Board:" if debug
  board.pretty_print if debug
  solution_state =  if type == 'breadth'
                      puts '-- Breadth Search --' if debug
                      breadth_search(board, debug)
                    elsif type == 'depth'
                      puts '-- Depth Search --' if debug
                      depth_search(board, debug)
                    elsif type == 'iterative'
                      puts '-- Iterative Breadth Search --' if debug
                      iterative_deepening_depth_search(
                        board, search_param, debug
                      )
                    elsif type == 'astar'
                      puts '-- A* Search --' if debug
                      astar(board, search_param, debug)
                    else
                      puts "No search found with the name #{type}" if debug
                      nil
                    end
  return if solution_state.nil?

  return unless debug

  movements = movement_trace(solution_state)
  puts 'Initial Board:'
  board.pretty_print
  puts "Movements to Solve: #{movements.length}"
  pretty_print_movement_trace(movements)
  puts 'Final Board:'
  pretty_print(solution_state.current_state)
end

# ------------ Search algorithms

# -- Breadth Search
def breadth_search(board, debug = false)
  queue = []
  queue.push(board.root)

  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:' if debug
  board.pretty_print if debug

  loop do
    # Gets state
    state = queue.shift(1).first

    # Prints number of states analyzed and current queue
    puts "Analyzed States: #{analyzed_states}" if debug
    puts "Current Queue Size: #{queue.length}" if debug
    puts "Current Level: #{state.level}\n\n" if debug

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
def depth_search(board, debug = false)
  queue = []
  queue.push(board.root)

  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:' if debug
  board.pretty_print if debug

  loop do
    # Gets state
    state = queue.pop
    # Prints number of states analyzed and current queue
    puts "Analyzed States: #{analyzed_states}" if debug
    puts "Current Queue Size: #{queue.length}" if debug
    puts "Current Level: #{state.level}\n\n" if debug

    # Breaks if it is the solution
    return state if board.solution?(state)

    # Pushes children into the queue
    queue += state.children if state.level < 30

    # Breaks if queue is empty
    break if queue.empty?

    # Bumps analyzed states counter
    analyzed_states += 1
  end

  # No solution, returns empty array
  []
end

# -- Depth Search
def iterative_deepening_depth_search(board, interval_size = 5, debug = false)
  analyzed_states = 0

  # Prints initial board
  puts 'Starting board:' if debug
  board.pretty_print if debug

  # Initialize max depth
  max_level = 0

  loop do
    # Updates max depth
    max_level += interval_size

    # Initialize queue
    queue = []
    queue.push(board.root)

    puts "\n\n-----\nCurrent Max Depth: #{max_level}:" if debug

    loop do
      # Gets state
      state = queue.pop
      # Prints number of states analyzed and current queue
      puts "Analyzed States: #{analyzed_states}" if debug
      puts "Current Queue Size: #{queue.length}" if debug
      puts "Current Level: #{state.level}\n\n" if debug

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

# -- A*

def astar(board, heuristic = 'manhattan', debug = false)
  # Prints initial board
  puts 'Starting board:' if debug
  board.pretty_print if debug

  # Current queue
  queue = FastContainers::PriorityQueue.new(:min)
  queue.push(
    board.root,
    heuristic(
      board.root.current_state, board.final_state.current_state, 'manhattan'
    ) +
      board.root.level
  )

  analyzed_states = 0

  loop do
    # Gets state
    state = queue.pop

    # Prints number of states analyzed and current queue
    puts "Analyzed States: #{analyzed_states}" if debug
    puts "Current Queue Size: #{queue.size}" if debug
    puts "Current Level: #{state.level}\n\n" if debug

    # Breaks if it is the solution
    return state if board.solution?(state)

    # Iterates children
    state.children.each do |child|
      queue.push(
        child,
        heuristic(
          child.current_state, board.final_state.current_state, 'manhattan'
        ) +
          child.level
      )
    end

    analyzed_states += 1

    # Break function
    break if queue.empty?
  end

  # No solution
  []
end

# -- Heuristics

# Main method
def heuristic(current, final, h = 'manhattan')
  if h == 'manhattan'
    manhattan_distance(current, final)
  else
    board_diff(current, final)
  end
end

# Manhattan
def manhattan_distance(current, final)
  count = 0
  (0..(current.length - 1)).each do |i|
    (0..(current.length - 1)).each do |j|
      count += ((current[i][j] / 3).to_i - (final[i][j] / 3).to_i).abs +
               (current[i][j] % 3 - final[i][j] % 3).abs
    end
  end
  count
end

# Board diffs
def board_diff(current, final)
  count = 0
  (0..(current.length - 1)).each do |i|
    (0..(current.length - 1)).each do |j|
      count += 1 if current[i][j] != final[i][j]
    end
  end
  count
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
