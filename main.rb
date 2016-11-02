#!/usr/bin/ruby

require_relative 'simulator'

threshold = 25
iterations = 10

simulator = Simulator.new threshold
simulator.run iterations
