range = 165432..707912

count = 0
range.each do |num|
  has_double       = false
  num_len          = num.to_s.length - 1
  num_str          = num.to_s.split('')[1..-1]
  prev_char        = num.to_s.split('')[0]
  num_str.each_with_index do |char, idx|
    break if char.to_i < prev_char.to_i
    has_double = true if prev_char == char
    if idx == num_len - 1 && has_double
      count += 1
    end
    prev_char = char
  end
end

puts count
