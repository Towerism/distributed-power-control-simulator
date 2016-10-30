# Represents a node
class Node
  attr_reader :id, :power

  def initialize(id, power, printer)
    @id = id
    @power = power
    @printer = printer
  end

  def readjust_power(minimum_transmit_threshold, interference, gain)
    @power = (minimum_transmit_threshold * interference) / gain
    @printer.print_power self if @power > 0
  end

  def id?(value)
    @id == value
  end
end
