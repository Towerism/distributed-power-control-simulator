# Represents an object which can calculate interference between nodes in a graph
class InterferenceCalculator
  def initialize(graph, noise)
    @graph = graph
    @noise = noise
  end

  def calculate_for(transmitter_id, receiver_id)
    set_paths_for_receiver_excluding_transmitter receiver_id, transmitter_id
    set_powers_and_gains
    interference_from_other_nodes + @noise
  end

  private

  def set_paths_for_receiver_excluding_transmitter(receiver_id, transmitter_id)
    paths_including_transmitter = @graph.get_all_for_receiver(receiver_id)
    @paths = paths_including_transmitter.select do |path|
      !path.transmitter_id? transmitter_id
    end
  end

  def set_powers_and_gains
    gains = @paths.collect(&:gain)
    powers = @paths.collect(&:transmit_power)
    @powers_and_gains = powers.zip gains
  end

  def interference_from_other_nodes
    @powers_times_gains = @powers_and_gains.collect do |power_and_gain|
      power_and_gain[0] * power_and_gain[1]
    end
    @powers_times_gains.inject(:+)
  end
end
