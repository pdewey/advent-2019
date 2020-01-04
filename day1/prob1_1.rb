#!/usr/bin/env ruby

sum = 0
file = IO.foreach("prob1_1.txt") { |line|
  sum += (line.to_i / 3).floor - 2
}

puts sum
