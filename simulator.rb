require_relative 'graph'
require_relative 'interference_calculator'
require_relative 'node'
require_relative 'printer'

# Represents the interface for the simulator
class Simulator
  def initialize minimum_transmit_threshold
    @threshold = minimum_transmit_threshold
    set_paths

    @interference_calculator = InterferenceCalculator.new @paths, 10**-10
  end

  def set_paths
    @printer = Printer.new

    @node_a = Node.new :A, 1, @printer
    @node_b = Node.new :B, 0, @printer
    @node_c = Node.new :C, 1, @printer
    @node_d = Node.new :D, 0, @printer

    @paths = Graph.new
    @paths.add_path(@node_a, @node_b, 10**-5)
    @paths.add_path(@node_a, @node_d, 10**-8.2)
    @paths.add_path(@node_c, @node_b, 10**-7.8)
    @paths.add_path(@node_c, @node_d, 10**-6)
  end

  def run(n)
    n.times do
      @printer.time += 1
      interference_for_a = @interference_calculator.calculate_for(@node_a, @node_b)
      gain_ab = @paths.get(:A, :B).gain
      @node_a.readjust_power(@threshold, interference_for_a, gain_ab)
      interference_for_c = @interference_calculator.calculate_for(@node_c, @node_d)
      gain_cd = @paths.get(:C, :D).gain
      @node_c.readjust_power(@threshold, interference_for_c, gain_cd)
      puts " "
    end
  end
end
