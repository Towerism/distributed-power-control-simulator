require_relative 'path'

# Represents a graph of Nodes
class Graph
  def initialize
    @paths = []
  end

  def add_path(transmitter_node, receiver_node, gain)
    return unless get(transmitter_node.id, receiver_node.id).nil?
    path = Path.new transmitter_node, receiver_node, gain
    @paths.push(path)
  end

  def get(transmitter_id, receiver_id)
    @paths.find { |path| path.ids?(transmitter_id, receiver_id) }
  end

  def get_all_for_transmitter(id)
    @paths.select { |path| path if path.transmitter_id?(id) }
  end

  def get_all_for_receiver(id)
    @paths.select { |path| path if path.receiver_id?(id) }
  end
end
