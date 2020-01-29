class Point
  attr_reader :x, :y

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
  end

  def to_s
    "(#{@x}, #{@y})"
  end
end

class Line
  attr_reader :x_seg, :y_seg, :start_point, :distance

  def initialize(x_seg, y_seg, start_point)
    @x_seg, @y_seg, @start_point = x_seg, y_seg, start_point
    if @x_seg.is_a? Range
      @distance = (@x_seg.end - @x_seg.begin).abs
    else
      @distance = (@y_seg.end - @y_seg.begin).abs
    end
  end

  def intersects?(line)
    return nil if @x_seg.is_a?(Range) && line.x_seg.is_a?(Range) || @y_seg.is_a?(Range) && line.y_seg.is_a?(Range)

    if @x_seg.is_a? Range
      if @x_seg.cover?(line.x_seg) && line.y_seg.cover?(@y_seg)
        return Point.new(line.x_seg, @y_seg) unless line.x_seg == 0 && @y_seg == 0
      end
    else
      if @y_seg.cover?(line.y_seg) && line.x_seg.cover?(@x_seg)
        return Point.new(@x_seg, line.y_seg) unless line.y_seg == 0 && @x_seg == 0
      end
    end
  end

  def has_point?(point)
    if @x_seg.is_a? Range
      @x_seg.cover?(point.x) && @y_seg == point.y
    else
      @y_seg.cover?(point.y) && @x_seg == point.x
    end
  end

  def distance_to_intersection(point)
    if @x_seg.is_a? Range
      (@start_point.x - point.x).abs
    else
      (@start_point.y - point.y).abs
    end
  end

  def to_s
    "(#{@x_seg}, #{@y_seg})"
  end
end

def build_line(orig, vector, wire)
  dir = vector[0]
  mag = vector[1..-1].to_i
  x = orig.x
  y = orig.y

  case dir
  when "R"
    wire << Line.new(x..(x + mag), y, orig)
    x += mag
  when "L"
    wire << Line.new((x - mag)..x, y, orig)
    x -= mag
  when "U"
    wire << Line.new(x, y..(y + mag), orig)
    y += mag
  when "D"
    wire << Line.new(x, (y - mag)..y, orig)
    y -= mag
  end
  Point.new(x, y)
end

wires  = []
origin = Point.new(0, 0)
File.open('prob3_1.txt').each do |line|
  curr_point = origin
  wire = []
  line.split(',').each do |segment|
    curr_point = build_line(curr_point, segment, wire)
  end
  wires << wire
end

intersections = []
distances = {}
wires[0].each do |line1|
  wires[1].each do |line2|
    point =  line1.intersects?(line2)
    intersections << point unless point.nil?
    distances[point] = { 0 => nil, 1 => nil } unless point.nil?
  end
end

wires.each_with_index do |wire, idx|
  curr_point = origin
  distance = 0
  wire.each do |segment|
    intersections.each do |intersection|
      if segment.has_point? intersection
        distances[intersection][idx] = distance + segment.distance_to_intersection(intersection) if distances[intersection][idx].nil?
      end
    end
    distance += segment.distance
  end
end

distance_vals = []
distances.each do |_, vals|
  distance_vals << vals[0] + vals[1]
end

puts distance_vals.min
