# Sliding Puzzle - Search Algorithms


Author: Nícolas Oreques de Araujo

Date: 09/04/2019

Available at: https://github.com/Naraujo13/eigth-game-graph-search

First Task from Artificial Intelligence (FIA) class at UFPel Masters Degree from 2019


# Structure

As a structure, two classes were created to represent the sliding puzzle challenge: [Board](board.rb) and [Node](node.rb).

The first, **Board**, represents the board of a given sliding puzzle, with NxN dimensions. It contains the initial and final state of this puzzle.

The second, **Node**, represents a given state of the board, representing a single node of a Board tree. This class contains the current state, represented as a NxN matrix, a  reference to it's father node (if it exists) and reference to it's possible children. To improve the performance, it also has the blank position x and y coordinates on the board, helping with heuristics indexing, and the level of this node (in relation to the board root).

To avoid unnecessary loops in children generation, reducing the number of nodes generated, it was implemented a simple function that returns the N parents (father, grandfather and so on) of the node. This function is used when generating it's children, not returning children that are equivalent states to it's predecessors. As this was implemented in the board itself, all the search algorithms use it and it doesn't affect the benchmark between them. The number of generations to go back to avoid the loop can be customized, but for this benchmark it was set to three (father, grandfather and grand-grandfather).

The search algorithms were implemented in Ruby using only the language native constructions (mainly it's native queue and stack with the main array class) and the gem [PriorityQueue](https://rubygems.org/gems/PriorityQueue) for, as the name says, the priority queue used in the A* algorithm. The search algorithms can be found in the file [search_methods.rb](search_methods.rb)

# Methodology

## Test Cases

It was used six test cases, with increasing difficulty with each needing more moves to solve and, consequentially, more nodes to expand and evaluate.

The six test cases are presented at the start of each benchmark, starting with a simple, 4 moves, case and finishing with a more complex, 19 moves, one.

It is important to emphasize that no test cases with higher difficulties (more than 19 moves) were used in the benchmark because of the high quantity of memory and processing time needed. Some test cases take near 30 moves to solve and, in those cases, it took and enormous amount of time (several hours in some cases) to run it a single time. Therefore, it made it difficult to perform a good benchmark, with many repetitions to ensure it's consistency.
In addition, the differences are visible in less complex cases, been only emphasized by the increased complexity of them.

For this reasons, it was better to choose less complex cases, allowing the use of a higher number of repetitions.

## Performance

To test the performance between the algorithms, it was used the native [benchmark gem](http://ruby-doc.org/stdlib-2.0.0/libdoc/benchmark/rdoc/Benchmark.html), executing each test case 30 times.

The ruby benchmark gem does a preliminary run of the tests cases before starting the real test, which it calls *Rehearsal*.
[It does so to force any initialization that needs to happen, ensuring that the system is fully initialized and the benchmark is fair](http://rubylearning.com/blog/2013/06/19/how-do-i-benchmark-ruby-code/).

Therefore, each test case following presents a table for the rehearsal results and a table for the real test results.

All test units are in seconds.

## Memory

To test the memory usage between the algorithms, it was used the [benchmark-memory gem](https://github.com/michaelherold/benchmark-memory), executing each test case 30 times.

This gem presents the retained and used quantities of the following metrics: total memory size, objects and strings. To this tests, the two first metrics are useful to analyze the number of allocated objects (nodes and etc.) and the total amount of memory used.

Therefore, each test case following will present this three metrics alongside the performance results.

# Benchmark with Board 1:

## Initial Board

### Best Case: 4 Moves
| | | |
|------------- | ------------ | ------------
| 1 | 0 | 3 |
| 4 | 2 | 6 |
| 7 | 5 | 8 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | ------------- |
| Depth Search: | 1.688000 | 0.016000 | 1.704000 | 1.702094 |
| Breadth Search: | 0.000000 | 0.000000 | 0.000000 | 0.000150 |
| Iterative Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.000594 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000078 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000076 |
| Total | | | | 1.704000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
| Depth Search: | 0.703000 | 0.000000 | 0.703000 | 0.704328 |
| Breadth Search: | 0.000000 | 0.000000 | 0.000000 | 0.000197 |
| Iterative Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.000469 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000171 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000106 |

## Memory

| Search | Retained | Allocated |
| ------------ | ------------- | -------------
| Depth Search: |  36.317M | 126.154M |
| Breadth Search: |  3.264k | 10.864k |
| Iterative Depth Search: |  9.248k | 33.264k |
| A* with Board Diff: | 0 | 3.944k |
| A* with Manhattan Distance: |  0 | 3.944k |


# Benchmark with Board 2:

## Initial Board

### Best Case: 9 Moves
| | | |
|------------- | ------------ | ------------
| 1 | 6 | 2 |
| 5 | 0 | 3 |
| 4 | 7 | 8 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | ------------- |
| Depth Search: | 0.078000 | 0.000000 | 0.078000 | 0.074314 |
| Breadth Search: | 0.000000 | 0.000000 | 0.000000 | 0.005867 |
| Iterative Depth Search: | 0.016000 | 0.000000 | 0.016000 | 0.002638 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000151 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000137 |
| Total | | | | 0.094000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
| Depth Search: | 0.015000 | 0.000000 | 0.015000 | 0.027193 |
| Breadth Search: | 0.000000 | 0.000000 | 0.000000 | 0.002327 |
| Iterative Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.001636 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000221 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000258 |

## Memory

| Search | Retained | Allocated |
| ------------ | ------------- | -------------
| Depth Search: |  1.801M | 6.152M |
| Breadth Search: |  122.944k | 395.376k |
| Iterative Depth Search: |  53.856k | 216.976k |
| A* with Board Diff: | 0 | 10.160k |
| A* with Manhattan Distance: |  0 | 10.160k |

# Benchmark with Board 3:

## Initial Board

### Best Case: 11 Moves
| | | |
|------------- | ------------ | ------------
| 2 | 4 | 3 |
| 1 | 0 | 8 |
| 7 | 6 | 5 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | ------------- |
| Depth Search: | 0.359000 | 0.000000 | 0.359000 | 0.358291 |
| Breadth Search: | 0.016000   0.000000 | 0.016000 | 0.018412 |
| Iterative Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.003742 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000644 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000852 |
| Total | | | | 0.375000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
| Depth Search: | 0.140000 | 0.000000 | 0.140000 | 0.136142 |
| Breadth Search: | 0.000000 | 0.000000 | 0.000000 | 0.009960 |
| Iterative Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.004639 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.000459 |
| A* with Manhattan Distance: | 0.000000 | 0.000000 | 0.000000 | 0.000457 |

## Memory

| Search | Retained | Allocated |
| ------------ | ------------- | -------------
| Depth Search: |  7.556M  | 25.665M |
| Breadth Search: |  336.192k | 1.057M |
| Iterative Depth Search: |  0 | 186.608k |
| A* with Board Diff: | 0 | 28.336k |
| A* with Manhattan Distance: |  0 | 28.336k |

# Benchmark with Board 4:

## Initial Board

### Best Case: 17 Moves
| | | |
|------------- | ------------ | ------------
| 4 | 2 | 3 |
| 8 | 6 | 1 |
| 0 | 7 | 5 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | ------------- |
| Depth Search: | 0.625000 | 0.000000 | 0.625000 | 0.635618 |
| Breadth Search: | 1.906000 | 0.422000 | 2.328000 | 2.394398 |
| Iterative Depth Search: | 0.609000 | 0.015000 | 0.624000 | 0.617715 |
| A* with Board Diff: | 0.000000 | 0.000000 | 0.000000 | 0.010549 |
| A* with Manhattan Distance: | 0.016000 | 0.000000 | 0.016000 | 0.011949 |
| Total | | | | 3.593000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
| Depth Search: | 0.203000 | 0.000000 | 0.203000 | 0.194905 |
| Breadth Search: | 0.750000 | 0.266000 | 1.016000 | 1.018159 |
| Iterative Depth Search: | 0.281000 | 0.000000 | 0.281000 | 0.285527 |
| A* with Board Diff: | 0.015000 | 0.000000 | 0.015000 | 0.009512 |
| A* with Manhattan Distance: | 0.015000 | 0.000000 | 0.015000 | 0.013156 |

## Memory

| Search | Retained | Allocated |
| ------------ | ------------- | -------------
| Depth Search: |  11.068M | 37.361M |
| Breadth Search: |  9.415M | 30.257M |
| Iterative Depth Search: |  10.443M | 39.972M |
| A* with Board Diff: | 1.904k | 604.632k |
| A* with Manhattan Distance: |  0 | 600.832k |

# Benchmark with Board 5:

## Initial Board

### Best Case: 19 Moves
| | | |
|------------- | ------------ | ------------
| 0 | 5 | 6 |
| 2 | 1 | 4 |
| 7 | 8 | 3 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
Depth Search: | 0.016000 | 0.000000 | 0.016000 | 0.012080 |
Breadth Search: | 3.328000 | 0.750000 | 4.078000 | 4.086289 |
Iterative Depth Search: | 1.812000 | 0.031000 | 1.843000 | 1.858363 |
A* with Board Diff: | 0.032000 | 0.000000 | 0.032000 | 0.031497 |
A* with Manhattan Distance: | 0.047000 | 0.000000 | 0.047000 | 0.034212 |
| Total | | | | 6.016000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
Depth Search: | 0.000000 | 0.000000 | 0.000000 | 0.004720 |
Breadth Search: | 3.203000 | 0.688000 | 3.891000 | 3.891205 |
Iterative Depth Search: | 0.594000 | 0.000000 | 0.594000 | 0.592312 |
A* with Board Diff: | 0.031000 | 0.000000 | 0.031000 | 0.034859 |
A* with Manhattan Distance: | 0.031000 | 0.000000 | 0.031000 | 0.027513 |

## Memory

All data is *retained/allocated*.

| Search | Retained | Allocated |
| ------------ | ------------- | -------------
| Depth Search: |  287.776k | 978.064k |
| Breadth Search: |  20.675M | 76.545M |
| Iterative Depth Search: |  13.018M | 115.837M |
| A* with Board Diff: |  13.600k | 1.901M |
| A* with Manhattan Distance: |  0 | 1.874M |

# Benchmark with Board 6:

## Initial Board

### Best Case: 25 Moves
| | | |
|------------- | ------------ | ------------
| 7 | 5 | 2 |
| 6 | 3 | 8 |
| 4 | 1 | 0 |

## Rehearsal
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
Depth Search: | 72.359000 | 0.797000 | 73.156000 | 73.205466 |
Breadth Search: | 1657.500000 | 152.031000 | 1809.531000 | 1813.370567 |
Iterative Depth Search: | 25.078000 | 0.156000 | 25.234000 | 25.328786 |
A* with Board Diff: | 0.094000 | 0.000000 | 0.094000 | 0.100111 |
A* with Manhattan Distance: | 0.093000 | 0.000000 | 0.093000 | 0.093854 |
| Total | | | | 1908.108000 |

## Real
| Search | user | system | total | real |
| ------------ | ------------- | ------------- | ------------- | -------------
Depth Search: | 27.312000 | 0.172000  | 27.484000 | 27.638541 |
Breadth Search: | 2010.422000 | 166.532000 | 2176.954000 | 2183.409649 |
Iterative Depth Search: | 10.437000 | 0.046000 | 10.483000 | 10.512768 |
A* with Board Diff: | 0.109000 | 0.000000 | 0.109000 | 0.115455 |
A* with Manhattan Distance: | 0.125000 | 0.000000 | 0.125000 | 0.113406 |

## Memory

For some not totally explained reason, the memory benchmarking gem wasn't able to run in this test case. Trying to run it caused the whole computer to freeze after a few seconds. Until the moment of writing of this report the reason was unknown (probably something related to this case demanding more memory than others, but why crash just when calling memory-benchmark is still unknown).

# Conclusion

After running all tests it's clear the advantage that the methods based on exploration instead of exploitation have.

A*, with any of the two heuristics, tops the performance for all cases and also excels in memory usage, with an advantage to using the Manhattan Distance Heuristic. This small, but significant difference between them occurs because Manhattan is an heuristic that better reflects the real case scenario for this problem. The simple difference from a board to another can, at least to some extent, reflect that a board is better than the other, but the real distance between this board and the final one is not represented, as it does not consider the real movement of between states.

It is important to notice, also, the comparison between Depth and Breadth Search.
In less complex cases, breadth excelled in runtime, but was outperformed memory-wise.
With more complex cases, the depth search simple couldn't finish and, after having a 12h+ run, had to be implemented with a max depth to finish. Being a non optimal algorithm, the Depth search sometimes return a sub-optimal solution. And, although it is considered a complete algorithm, always returning a solution if one exists, in some cases it didn't return one, getting stuck in loops.

Another interesting point is the comparison between the Breadth and Iterative Depth search. Most cases the Iterative had an advantage over the regular in terms of runtime performance, what was already expected, specially for the less complex cases. What is interesting in this comparison is the memory usage of both algorithms:the iterative has a higher amount of total memory allocated during its lifetime, but, at the end of it's run, when it found a solution, it had almost half the retained memory of the breadth search.

The higher amount of allocated memory in the Iterative can be explained by the fact that it executes a normal Breadth-Search limiting it's maximum depth, restarting with a bigger one if no solution is found. This restarting factor makes it accumulate a higher amount of allocated memory (given it's various 'runs'), but given the fact that it only needs the current run in it's memory, it also explains the smaller amount of retained memory in the benchmarks.
