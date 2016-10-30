# Represents a printer for summary and iteration reports
class Printer
  attr_accessor :time

  def initialize
    @time = 0
  end

  def print_power node
    puts "power_#{node.id}(#{@time}) = #{node.power}"
  end
end
