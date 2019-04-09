require 'benchmark'
load 'search_methods.rb'

def depth(board)
  search(board, 'depth', nil, false)
end

def breadth(board)
  search(board, 'breadth', nil, false)
end

def iterative_breadth(board)
  search(board, 'iterative', 5, false)
end

def board_diff(board)
  search(board, 'astar', 'board_diff', false)
end

def manhattan(board)
  search(board, 'astar', 'manhattan', false)
end

# ----- Benchmark Preparations

puts 'Preparing benchmark...'

# Creates test cases

# 4 Moves
board1 = Board.new(
  3,
  [
    [1, 0, 3],
    [4, 2, 6],
    [7, 5, 8]
  ]
)

# 9 Moves
board2 = Board.new(
  3,
  [
    [1, 6, 2],
    [5, 0, 3],
    [4, 7, 8]
  ]
)

# 11 Moves
board3 = Board.new(
  3,
  [
    [2, 4, 3],
    [1, 0, 8],
    [7, 6, 5]
  ]
)

# 17 Moves
board4 = Board.new(
  3,
  [
    [4, 2, 3],
    [8, 6, 1],
    [0, 7, 5]
  ]
)

# 19 Moves
board5 = Board.new(
  3,
  [
    [0, 5, 6],
    [2, 1, 4],
    [7, 8, 3]
  ]
)

# 25 Moves
board6 = Board.new(
  3,
  [
    [7, 5, 2],
    [6, 3, 8],
    [4, 1, 0]
  ]
)

# 28 Moves
board7 = Board.new(
  3,
  [
    [8, 2, 6],
    [7, 3, 4],
    [1, 0, 5]
  ]
)

# --- Benchmark with board 1
puts 'Benchmark with Board 1:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board1) }
  x.report('Breadth Search:') { breadth(board1) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board1) }
  x.report('Manhattan Board Diff:') { board_diff(board1) }
  x.report('Manhattan A*:') { manhattan(board1) }
end

# --- Benchmark with board 2
puts 'Benchmark with Board 2:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board2) }
  x.report('Breadth Search:') { breadth(board2) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board2) }
  x.report('Manhattan Board Diff:') { board_diff(board2) }
  x.report('Manhattan A*:') { manhattan(board2) }
end

# --- Benchmark with board 3
puts 'Benchmark with Board 3:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board3) }
  x.report('Breadth Search:') { breadth(board3) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board3) }
  x.report('Manhattan Board Diff:') { board_diff(board3) }
  x.report('Manhattan A*:') { manhattan(board3) }
end

# --- Benchmark with board 4
puts 'Benchmark with Board 4:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board4) }
  x.report('Breadth Search:') { breadth(board4) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board4) }
  x.report('Manhattan Board Diff:') { board_diff(board4) }
  x.report('Manhattan A*:') { manhattan(board4) }
end

# --- Benchmark with board 5
puts 'Benchmark with Board 5:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board5) }
  x.report('Breadth Search:') { breadth(board5) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board5) }
  x.report('Manhattan Board Diff:') { board_diff(board5) }
  x.report('Manhattan A*:') { manhattan(board5) }
end

# --- Benchmark with board 6
puts 'Benchmark with Board 6:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board6) }
  x.report('Breadth Search:') { breadth(board6) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board6) }
  x.report('Manhattan Board Diff:') { board_diff(board6) }
  x.report('Manhattan A*:') { manhattan(board6) }
end

# --- Benchmark with board 7
puts 'Benchmark with Board 7:'
Benchmark.bmbm(11) do |x|
  x.report('Depth Search:') { depth(board7) }
  x.report('Breadth Search:') { breadth(board7) }
  x.report('Iterative Breadth Search:') { iterative_breadth(board7) }
  x.report('Manhattan Board Diff:') { board_diff(board7) }
  x.report('Manhattan A*:') { manhattan(board7) }
end
