require 'byebug'

class Node
  # -- Acessors
  attr_reader :current_state
  attr_reader :blank_x
  attr_reader :blank_y
  attr_reader :father
  attr_reader :level

  # -- Returns the board size - as a square board, returns the x dimension
  def size
    current_state.length
  end

  # -- Returns the node that represents the board state when moving the piece
  # below the blank space up. If the movement is not possible, return nil.
  def up_child
    # Returns up_child unless it's nil
    return @up_child unless @up_child.nil?

    # If passed the guard, up_child was not calculated yet, so generates it,
    # stores a ref and return the node
    @up_child = calculate_up_child
    @up_child
  end

  # -- Returns the node that represents the board state when moving the piece
  # above the blank space down. If the movement is not possible, return nil.
  def down_child
    # Returns down_child unless it's nil
    return @down_child unless @down_child.nil?

    # If passed the guard, down_child was not calculated yet, so generates it,
    # stores a ref and return the node
    @down_child = calculate_down_child
    @down_child
  end

  # -- Returns the node that represents the board state when moving the piece
  # to the left of the blank space right. If the movement is not possible,
  # return nil.
  def left_child
    # Returns left_child unless it's nil
    return @left_child unless @left_child.nil?

    # If passed the guard, left_child was not calculated yet, so generates it,
    # stores a ref and return the node
    @left_child = calculate_left_child
    @left_child
  end

  # -- Returns the node that represents the board state when moving the piece
  # to the right of the blank space left. If the movement is not possible,
  # return nil.
  def right_child
    # Returns right_child unless it's nil
    return @right_child unless @right_child.nil?

    # If passed the guard, right_child was not calculated yet, so generates it,
    # stores a ref and return the node
    @right_child = calculate_right_child
    @right_child
  end

  # -- Returns array with all children nodes
  def children
    children = []
    children << up_child unless up_child.nil?
    children << down_child unless down_child.nil?
    children << left_child unless left_child.nil?
    children << right_child unless right_child.nil?
    children
  end

  # Initializer
  def initialize(state, father = nil, blank_x = nil, blank_y = nil)
    @current_state = state
    @father = father
    @level =  if father.nil?
                0
              else
                father.level + 1
              end
    @up_child = nil
    @down_child = nil
    @left_child = nil
    @right_child = nil
    @blank_y, @blank_x = if blank_y.nil? || blank_x.nil?
                           blank_pos
                         else
                           [blank_y, blank_x]
                         end
  end

  # ---------- Initializer Auxiliary Methods

  def blank_pos
    size.times do |i|
      size.times do |j|
        return [i, j] if current_state[i][j].zero?
      end
    end
  end

  # ----------

  private

  # ---------- Movement Auxiliary Methods

  # -- Up

  # Calculates up child, if it exists, stores ref and return it
  def calculate_up_child
    # Guard condition for movement not possible
    return nil if blank_y + 1 == size

    # Make the movement
    new_state = swap_up

    # Returns new node
    Node.new(new_state, self, blank_x, blank_y + 1)
  end

  # Swaps positions - a.k.a. make the movement
  def swap_up
    # Creates new state matrix
    new_state = current_state_dup

    # Swap values
    new_state[blank_y][blank_x] = new_state[blank_y + 1][blank_x]
    new_state[blank_y + 1][blank_x] = 0

    # Returns new matrix
    new_state
  end

  # -- Down

  # Calculates down child, if it exists, stores ref and return it
  def calculate_down_child
    # Guard condition for movement not possible
    return nil if blank_y - 1 < 0

    # Make the movement
    new_state = swap_down

    # Returns new node
    Node.new(new_state, self, blank_x, blank_y - 1)
  end

  # Swaps positions - a.k.a. make the movement
  def swap_down
    # Creates new state matrix
    new_state = current_state_dup

    # Swap values
    new_state[blank_y][blank_x] = new_state[blank_y - 1][blank_x]
    new_state[blank_y - 1][blank_x] = 0

    # Returns new matrix
    new_state
  end

  # -- Left

  # Calculates left child, if it exists, stores ref and return it
  def calculate_left_child
    # Guard condition for movement not possible
    return nil if blank_x + 1 == size

    # Make the movement
    new_state = swap_left

    # Returns new node
    Node.new(new_state, self, blank_x + 1, blank_y)
  end

  # Swaps positions - a.k.a. make the movement
  def swap_left
    # Creates new state matrix
    new_state = current_state_dup

    # Swap values
    new_state[blank_y][blank_x] = new_state[blank_y][blank_x + 1]
    new_state[blank_y][blank_x + 1] = 0

    # Returns new matrix
    new_state
  end

  # -- Right

  # Calculates right child, if it exists, stores ref and return it
  def calculate_right_child
    # Guard condition for movement not possible
    return nil if blank_x - 1 < 0

    # Make the movement
    new_state = swap_right

    # Returns new node
    Node.new(new_state, self, blank_x - 1, blank_y)
  end

  # Swaps positions - a.k.a. make the movement
  def swap_right
    # Creates new state matrix
    new_state = current_state_dup

    # Swap values
    new_state[blank_y][blank_x] = new_state[blank_y][blank_x - 1]
    new_state[blank_y][blank_x - 1] = 0

    # Returns new matrix
    new_state
  end

  def current_state_dup
    Marshal.load(Marshal.dump(current_state))
  end

  # ----------
end
