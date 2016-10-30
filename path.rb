# Represents a path between two nodes
class Path
  attr_reader :gain

  def initialize(transmitter_node, receiver_node, gain)
    @transmitter = transmitter_node
    @receiver = receiver_node
    @gain = gain
  end

  def ids?(transmitter_id, receiver_id)
    @transmitter.id?(transmitter_id) && @receiver.id?(receiver_id)
  end

  def transmitter_id?(id)
    @transmitter == id
  end

  def receiver_id?(id)
    @receiver == id
  end

  def transmit_power
    @transmitter.power
  end
end
