orig = []
File.open('prob2_1.txt').each do |line|
  orig = line.split(',').map(&:to_i)
end

exit_program = false
for i in 1..99 do
  for j in 1..99 do
    arr = orig.map(&:clone)
    arr[1] = i
    arr[2] = j

    idx = 0

    while idx < arr.length && arr[idx] != 99
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
        break
      end

      idx += 4
    end

    if arr[0] == 19690720
      puts 100 * i + j
      exit_program = true
      break
    end
  end

  break if exit_program
end
