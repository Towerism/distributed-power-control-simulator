require_relative 'graph'
require_relative 'interference_calculator'
require_relative 'node'
require_relative 'printer'

# Represents the interface for the simulator
class Simulator
  def initialize(minimum_transmit_threshold)
    @threshold = convert_decibels minimum_transmit_threshold
    @printer = Printer.new
    set_nodes
    set_paths
    @interference_calculator = InterferenceCalculator.new @paths, 10**-13
  end

  def convert_decibels(decibels)
    20 * Math.log10(decibels)
  end

  def run(n)
    n.times do
      @printer.time += 1
      run_adjustments
      puts ' '
    end
  end

  private

  def set_nodes
    @node_a = Node.new :A, 10**-3, @printer
    @node_b = Node.new :B, 0, @printer
    @node_c = Node.new :C, 10**-3, @printer
    @node_d = Node.new :D, 0, @printer
  end

  def set_paths
    @paths = Graph.new
    @paths.add_path(@node_a, @node_b, 10**-5)
    @paths.add_path(@node_a, @node_d, 10**-8.2)
    @paths.add_path(@node_c, @node_b, 10**-7.8)
    @paths.add_path(@node_c, @node_d, 10**-6)
  end

  def run_adjustments
    run_adjustment_between(@node_a, @node_b)
    run_adjustment_between(@node_c, @node_d)
  end

  def run_adjustment_between(transmitter, receiver)
    interference = @interference_calculator.calculate_for(transmitter, receiver)
    gain = @paths.get(transmitter.id, receiver.id).gain
    transmitter.readjust_power(@threshold, interference, gain)
  end
end
