require 'set'

class Satellite
  attr_accessor :label, :orbits, :satellites
  def initialize(label, orbits = nil, satellites = [])
    @label, @orbits = label, orbits
    @satellites = []
  end

  def to_s
    "#{@label}"
  end

  def eql?(that)
    hash == that.hash
  end

  def hash
    @label.hash
  end
end

orbits = {}

def bfs(orbits, origin, dest)
  dist  = 0
  queue = [[dist, origin.orbits]]
  seen  = Set[origin]

  while not queue.empty?
    curr_dist, curr = queue.shift
    seen << curr

    sat_list = [curr.orbits].concat curr.satellites
    sat_list.each do |sat|
      if not seen.include? sat
        queue << [curr_dist + 1, sat]

        if sat.label == "SAN"
          return curr_dist
        end
      end
    end
    dist += 1
  end
end

File.open('prob6_2.txt').each do |line|
  label1, label2 = line.strip.split(')')
  sat1 = orbits.has_key?(label1) ? orbits[label1] : Satellite.new(label1)
  sat2 = orbits.has_key?(label2) ? orbits[label2] : Satellite.new(label2)

  orbits[label1] = sat1
  orbits[label2] = sat2
  sat1.satellites << sat2
  sat2.orbits = sat1
end

puts bfs(orbits, orbits["YOU"], orbits["SAN"])
