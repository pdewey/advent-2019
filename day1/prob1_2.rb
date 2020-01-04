#!/usr/bin/env ruby

sum = 0
file = IO.foreach("prob1_1.txt") { |line|
  fuel_needed = (line.to_i / 3).floor - 2

  while fuel_needed > 0
    sum += fuel_needed
    fuel_needed = (fuel_needed / 3).floor - 2
  end

}

puts sum
