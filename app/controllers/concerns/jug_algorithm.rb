class JugAlgorithm
  #The steps counter will increment by 1 everytime we perform an action (fill, dump, transfer)
  @@steps = 0
  @@states = []
  @@stepHash = {}

  def initialize(jug1, jug2, targetAmount)
    # Create WaterJugs objects that have a symbol assigned and the maximum capacity
    @jug1 = WaterJug.new(jug1, 'x')
    @jug2 = WaterJug.new(jug2, 'y')
    @targetAmount = targetAmount
    @selectedJug = nil
  end

  # Script method that returns the smaller set of steps to reach the desired result.
  def calculate
    # If the desired amount is higher than both jugs of water, there is no solution
    return 'No solution' if (@targetAmount > @jug1.max_capacity) && (@targetAmount > @jug2.max_capacity)
    # Try the 2 methods and store the steps
    jug1ToJug2 = fill_algorithm(@jug1, @jug2)
    jug2ToJug1 = fill_algorithm(@jug2, @jug1)
    # If both solutions return nil, there is no solution
    return 'No solution' if jug1ToJug2.nil? && jug2ToJug1.nil?
    # Select the solution that has less steps
    jug1ToJug2.length < jug2ToJug1.length ? jug1ToJug2 : jug2ToJug1
  end

  # This algorithm perform the following steps:
  # 1. Resets the state of the class so it can work with clean data.
  # 2. While it hasn't reached a result it:
  #   2.1 Check if the outJug is empty, if it is, refill the water.
  #   2.2 Transfers the water from outJug to inJug.
  #   2.3 If the inJug is full, empties it.
  # 3. Repeat until we reach the desired result or we reach a previously visited state, preventing an infinite loop.
  def fill_algorithm(outJug, inJug)
    reset_state
    until (reached_result?) do
      # If there are duplicates states that means we are in an infinite loop, return nil
      # so we know there's no solution with this method.
      return nil if @@states.uniq.length != @@states.length
      refill_water(outJug, inJug)
      break if reached_result?
      transfer_water(outJug, inJug)
      break if reached_result?
      dump_water(outJug, inJug)
    end
    return @@stepHash
  end

  # Refills the outJug water, increases @@steps by 1, stores the current state of the jugs
  # to @@states and stores the step to the @@stepHash.
  def refill_water(outJug, inJug)
    if outJug.empty?
      @@steps += 1
      outJug.fill
      @@states.push([outJug.current_amount, inJug.current_amount])
      @@stepHash["step#{@@steps}"] = createStep("Fill bucket #{outJug.symbol}")
    end
  end

  # Dumps the water from outJug, increases @@steps by 1, stores the current state of the jugs
  # to @@states and stores the step to the @@stepHash.
  def dump_water(outJug, inJug)
    if inJug.full?
      @@steps += 1
      inJug.empty
      @@states.push([outJug.current_amount, inJug.current_amount])
      @@stepHash["step#{@@steps}"] = createStep("Empty bucket #{inJug.symbol}")
    end
  end

  # Transfer water from outJug to inJug, increases @@steps by 1, stores the current state of the jugs
  # to @@states and stores the step to the @@stepHash.
  def transfer_water(outJug, inJug)
    outJug.transfer(inJug)
    @@steps+=1
    @@states.push([outJug.current_amount, inJug.current_amount])
    @@stepHash["step#{@@steps}"] = createStep("Transfer from bucket #{outJug.symbol} to bucket #{inJug.symbol}")
  end

  # Return a hash containing the state of the two jugs and the explanation of the step.
  def createStep(explain)
    {bucket_x: @jug1.current_amount, bucket_y: @jug2.current_amount, explanation: explain}
  end

  # Return true if one of the jugs reached the desired amount.
  def reached_result?
    (@jug1.current_amount == @targetAmount) || (@jug2.current_amount == @targetAmount)
  end

  # Reset the state of the class variables and the values of the jugs.
  def reset_state
    @@steps = 0
    @@states = []
    @@stepHash = {}
    @jug1.current_amount = 0
    @jug2.current_amount = 0
  end
end
