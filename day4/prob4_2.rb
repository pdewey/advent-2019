range = 165432..707912

count = 0
range.each do |num|
  has_double       = false
  in_chain         = false
  chain_count      = 0
  num_len          = num.to_s.length - 1
  num_str          = num.to_s.split('')[1..-1]
  prev_char        = num.to_s.split('')[0]
  num_str.each_with_index do |char, idx|
    break if char.to_i < prev_char.to_i
    if !in_chain && prev_char == char
      in_chain = true
      chain_count = 2
      if idx == num_len - 1
        has_double = true
      end
    elsif in_chain && prev_char == char
      chain_count += 1
    elsif in_chain && prev_char != char && chain_count == 2
      has_double = true
    else
      in_chain = false
      chain_count = 0
    end

    if idx == num_len - 1 && has_double
      count += 1
    end
    prev_char = char
  end
end

puts count
