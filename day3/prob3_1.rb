class Point
  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def manhattan_distance
    (@x).abs + (@y).abs
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

class Line
  attr_reader :p1, :p2

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end

  def self.find_intersection(line1, line2)
    return nil if line1.is_vertical? && line2.is_vertical? || line1.is_horizontal? && line2.is_horizontal?
    if line1.is_vertical?
      vert_line = line1
      hort_line = line2
    else
      vert_line = line2
      hort_line = line1
    end

    max_x = hort_line.find_big_x
    min_x = hort_line.find_small_x
    max_y = vert_line.find_big_y
    min_y = vert_line.find_small_y

    if (vert_line.p1.x >= min_x && vert_line.p1.x <= max_x &&
      hort_line.p1.y >= min_y && hort_line.p1.y <= max_y)
       intersect = Point.new(vert_line.p1.x, hort_line.p1.y)
       return nil if intersect.x == 0 && intersect.y == 0
       intersect
    else
      nil
    end
  end

  def is_vertical?
    @p1.x == @p2.x
  end

  def is_horizontal?
    @p1.y == @p2.y
  end

  def find_big_x
    @p1.x > @p2.x ? @p1.x : @p2.x
  end

  def find_small_x
    @p1.x < @p2.x ? @p1.x : @p2.x
  end

  def find_big_y
    @p1.y > @p2.y ? @p1.y : @p2.y
  end

  def find_small_y
    @p1.y < @p2.y ? @p1.y : @p2.y
  end

  def to_s
    "[#{@p1}, #{@p2}]"
  end
end

def find_line_end(orig, vector)
  dir = vector[0]
  mag = vector[1..-1].to_i

  case dir
  when "R"
    Point.new(orig.x + mag, orig.y)
  when "L"
    Point.new(orig.x - mag, orig.y)
  when "U"
    Point.new(orig.x, orig.y + mag)
  when "D"
    Point.new(orig.x, orig.y - mag)
  end
end

wires  = []
origin = Point.new(0, 0)
File.open('prob3_1.txt').each do |line|
  curr_point = origin
  wire = []
  line.split(',').each do |segment|
    end_point = find_line_end(curr_point, segment)
    wire << Line.new(curr_point, end_point)
    curr_point = end_point
  end
  wires << wire
end

distances = []
wires[0].each do |line1|
  wires[1].each do |line2|
    point =  Line.find_intersection(line1, line2)
    distances << point.manhattan_distance unless point.nil?
  end
end

p distances.min
