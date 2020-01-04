File.open('prob2_1.txt').each do |line|
  arr = line.split(',').map(&:to_i)
  idx = 0

  while idx < arr.length
    opcode = arr[idx]
    op1    = arr[arr[idx + 1]]
    op2    = arr[arr[idx + 2]]
    pos    = arr[idx + 3]

    case opcode
    when 1
      arr[pos] = op1 + op2
    when 2
      arr[pos] = op1 * op2
    else
      puts "ERROR: #{opcode}"
      break
    end
    idx += 4
  end

  puts arr[0]
end
