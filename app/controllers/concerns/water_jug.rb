class WaterJug
  attr_accessor :current_amount
  attr_reader :max_capacity, :symbol
  # Initialize the object with the maximun amount of galloons it can hold.
  def initialize(max_capacity, symbol)
    @max_capacity = max_capacity
    @symbol = symbol
    @current_amount = 0
  end

  # Fill the water jug to it's maximum capacity.
  def fill
    @current_amount = @max_capacity
  end

  # Dump the contents of the water jug.
  def empty
    @current_amount = 0
  end

  # Transfer the content of this water jug to another if the target water jug can hold it.
  def transfer(target)
    # The available space is the amount of water galloons that the jug can still take.
    available_space = target.max_capacity - target.current_amount
    # If there is no space for all the water, substract the available space from the current amount of water and
    # add it to the target jug, otherwise pour all the contents in the target jug.
    if available_space < @current_amount
      target.current_amount += available_space
      @current_amount -= available_space
    else
      target.current_amount += @current_amount
      empty
    end
  end

  # Checks whether the jug is empty or still contains water.
  def empty?
    return @current_amount == 0
  end

  # Checks if the water jug is at max capacity.
  def full?
    return @current_amount == @max_capacity
  end
end
